//
//  Header.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 27/08/25.
//

import Foundation

struct Header {
    var magic: UInt32
    var count: UInt32
    var offset: UInt32
    var unk2: UInt32
    var unk3: UInt32
    var unk4: UInt32
    var unk5: UInt32
    var unk6: UInt32
    var unk7: UInt32

    static let size = 9 * MemoryLayout<UInt32>.size
}
