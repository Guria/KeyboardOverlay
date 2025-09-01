//
//  KeyLayoutUtil.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 27/08/25.
//

import Foundation
import Carbon

class KeyLayoutUtil {
    
    static func readUInt32(_ data: Data, offset: Int) -> UInt32 {
        let value = data.subdata(in: offset..<offset+4).withUnsafeBytes {
            $0.load(as: UInt32.self)
        }
        return UInt32(littleEndian: value)
    }
    
    static func readHeader(from data: Data) -> Header {
        return Header(
            magic: readUInt32(data, offset: 0),
            count: readUInt32(data, offset: 4),
            offset: readUInt32(data, offset: 8),
            unk2: readUInt32(data, offset: 12),
            unk3: readUInt32(data, offset: 16),
            unk4: readUInt32(data, offset: 20),
            unk5: readUInt32(data, offset: 24),
            unk6: readUInt32(data, offset: 28),
            unk7: readUInt32(data, offset: 32)
        )
    }
    
    static func readEntry(from data: Data, at offset: Int) -> Entry {
        return Entry(
            zero: readUInt32(data, offset: offset + 0),
            keyLayoutNameOffset: readUInt32(data, offset: offset + 4),
            keyLayoutNumber: readUInt32(data, offset: offset + 8),
            flags: readUInt32(data, offset: offset + 12),
            localeOffset: readUInt32(data, offset: offset + 16),
            unkFlags: readUInt32(data, offset: offset + 20),
            keyLayoutDataSize: readUInt32(data, offset: offset + 24),
            keyLayoutDataAddr: readUInt32(data, offset: offset + 28),
            unkSize: readUInt32(data, offset: offset + 32),
            unkAddr: readUInt32(data, offset: offset + 36),
            iconSize: readUInt32(data, offset: offset + 40),
            iconAddr: readUInt32(data, offset: offset + 44),
            modPlistSize: readUInt32(data, offset: offset + 48),
            modPlistAddr: readUInt32(data, offset: offset + 52),
            plistSize: readUInt32(data, offset: offset + 56),
            plistAddr: readUInt32(data, offset: offset + 60)
        )
    }
    
    static func readNullTerminatedString(from data: Data, at offset: Int) -> String {
        var end = offset
        while end < data.count && data[end] != 0 {
            end += 1
        }
        let stringData = data.subdata(in: offset..<end)
        return String(data: stringData, encoding: .utf8) ?? "<invalid utf8>"
    }
    
    static func findKeyLayoutData(named layoutName: String) -> Data? {
        let path = "/System/Library/Keyboard Layouts/AppleKeyboardLayouts.bundle/Contents/Resources/AppleKeyboardLayouts-L.dat"

        guard let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }

        let header = KeyLayoutUtil.readHeader(from: fileData)
        guard header.magic == 0xABCDEF02 else {
            return nil
        }

        for i in 0..<header.count {
            let entryOffset = Int(header.offset) + Int(i) * Entry.size
            let entry = KeyLayoutUtil.readEntry(from: fileData, at: entryOffset)
            guard entry.zero == 0 else { continue }

            let name = KeyLayoutUtil.readNullTerminatedString(from: fileData, at: Int(entry.keyLayoutNameOffset))
            if name == layoutName {
                let layoutRange = Int(entry.keyLayoutDataAddr)..<Int(entry.keyLayoutDataAddr + entry.keyLayoutDataSize)
                return fileData.subdata(in: layoutRange)
            }
        }

        return nil
    }
    
    static func buildKeyLayoutMap(forLayoutName name: String, modifierKeyState: UInt32 = 0) -> [UInt16: String]? {
        guard let layoutData = findKeyLayoutData(named: name) else {
            return nil
        }

        var keyMap: [UInt16: String] = [:]

        layoutData.withUnsafeBytes { rawBufferPointer in
            guard let baseAddress = rawBufferPointer.baseAddress else { return }
            let layoutPtr = baseAddress.assumingMemoryBound(to: UCKeyboardLayout.self)

            let keyCodeArray: [UInt16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                          11, 12, 13, 14, 15, 16, 17, 18,
                                          19, 20, 21, 22, 23, 24, 25, 26,
                                          27, 28, 29, 30, 31, 32, 33, 34,
                                          35, 37, 38, 39, 40, 41, 42, 43,
                                          44, 45, 46, 47, 50]
            
            for keyCode in keyCodeArray {
                var deadKeyState: UInt32 = 0
                var chars: [UniChar] = Array(repeating: 0, count: 4)
                var actualLength: Int = 0

                let result = UCKeyTranslate(layoutPtr,
                                            keyCode,
                                            UInt16(kUCKeyActionDisplay),
                                            ((modifierKeyState) >> 8) & 0xFF,
                                            UInt32(LMGetKbdType()),
                                            UInt32(kUCKeyTranslateNoDeadKeysBit),
                                            &deadKeyState,
                                            chars.count,
                                            &actualLength,
                                            &chars)

                if result == noErr {
                    let string = String(utf16CodeUnits: chars, count: actualLength)
                    keyMap[keyCode] = string
                } else {
                    keyMap[keyCode] = ""
                }
            }
        }

        return keyMap
    }
    
    static func getCurrentKeyboardLayoutName() -> String? {
        guard let inputSource = TISCopyCurrentKeyboardLayoutInputSource()?.takeRetainedValue() else {
            return nil
        }

        guard let idPtr = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID) else {
            return nil
        }

        let cfStr = Unmanaged<CFString>.fromOpaque(idPtr).takeUnretainedValue()
        let inputSourceID = cfStr as String

        if inputSourceID.hasPrefix("com.apple.keylayout.") {
            return String(inputSourceID.dropFirst("com.apple.keylayout.".count))
        }

        return nil

    }

}
