//
//  Entry.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 27/08/25.
//

import Foundation

struct Entry {
    var zero: UInt32
    var keyLayoutNameOffset: UInt32
    var keyLayoutNumber: UInt32
    var flags: UInt32
    var localeOffset: UInt32
    var unkFlags: UInt32
    var keyLayoutDataSize: UInt32
    var keyLayoutDataAddr: UInt32
    var unkSize: UInt32
    var unkAddr: UInt32
    var iconSize: UInt32
    var iconAddr: UInt32
    var modPlistSize: UInt32
    var modPlistAddr: UInt32
    var plistSize: UInt32
    var plistAddr: UInt32

    static let size = 16 * MemoryLayout<UInt32>.size
}
