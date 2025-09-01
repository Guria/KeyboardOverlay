//
//  KeyCharView.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 31/08/25.
//

import SwiftUI

struct KeyCharView: View {
    var keyChar: String?
    
    private let primaryFont = CTFontCreateWithName("SF Pro Text" as CFString, 40, nil)
    private let helvetica = CTFontCreateWithName("Helvetica Neue" as CFString, 40, nil)
    
    var body: some View {
        if let char = keyChar {
            Text(formatKeyChar(text: char))
                .foregroundStyle(Color.white)
                .shadow(color: .black.opacity(0.7), radius: 3)
                .shadow(color: .black.opacity(0.6), radius: 6, y: 3)
                .compositingGroup()
                .opacity(0.55)
        }
    }
    
    private func formatKeyChar(text: String) -> AttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            kCTFontAttributeName as NSAttributedString.Key: primaryFont,
        ]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        for (i, scalar) in text.unicodeScalars.enumerated() {
            if scalar == "\u{02DD}" {
                attributedString.addAttribute(
                    kCTFontAttributeName as NSAttributedString.Key,
                    value: helvetica,
                    range: NSRange(location: i, length: 1)
                )
            }
        }
        
        return AttributedString(attributedString)
    }
}
