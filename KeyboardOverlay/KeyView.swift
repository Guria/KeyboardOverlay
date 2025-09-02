//
//  KeyView.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 26/08/25.
//

import SwiftUI

struct KeyView: View {
    var keyChar: String?
    var keyWidth: KeyWidthEnum = .small
    var isKeyPressed: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
                .shadow(color: .black.opacity(0.7), radius: 4)
                .shadow(color: .black.opacity(0.5), radius: 8, y: 4)
                .compositingGroup()
            
            if #available(macOS 14.0, *) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 4)
                    .fill(Color.black)
                    .blendMode(.destinationOut)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 4)
                    .background(Color.black)
                    .blendMode(.destinationOut)
            }
        }
        .compositingGroup()
        .frame(width: keyWidth.getWidth(), height: 75)
        .overlay {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isKeyPressed ?
                                Color.accentColor.opacity(0.5) :
                                Color.white.opacity(0.15),
                                lineWidth: 4)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black)
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.black.opacity(0.35))
                
                if (isKeyPressed) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor.opacity(0.15))
                }
            }
            .overlay {
                KeyCharView(keyChar: keyChar)
            }
        }
    }
}
