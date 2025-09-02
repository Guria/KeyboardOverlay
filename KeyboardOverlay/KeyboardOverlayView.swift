//
//  KeyboardOverlayView.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 26/08/25.
//

import SwiftUI
import Cocoa
import Carbon

struct KeyboardOverlayView: View {
    
    @StateObject var keyLayoutObserver = KeyboardLayoutObserver()
    @StateObject private var appState = AppState()
    
    @State private var showOverlay: Bool = true
    
    var body: some View {
        if #available(macOS 14.0, *) {
            GeometryReader { parent in
                if (showOverlay) {
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[50])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[18])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[19])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[20])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[21])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[23])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[22])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[26])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[28])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[25])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[29])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[27])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[24])
                                KeyView(keyChar: keyLayoutObserver.currentModifiers.contains(.function) ? "⌦" : "⌫",
                                        keyWidth: .medium)
                            }
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: "⇥", keyWidth: .medium)
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[12])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[13])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[14])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[15])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[17])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[16])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[32])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[34])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[31])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[35])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[33])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[30])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[42])
                            }
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: "⇪", keyWidth: .large,
                                        isKeyPressed: keyLayoutObserver.currentModifiers.contains(.capsLock))
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[0])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[1])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[2])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[3])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[5])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[4])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[38])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[40])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[37])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[41])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[39])
                                KeyView(keyChar: keyLayoutObserver.currentModifiers.contains(.function) ? "⌤" : "⏎",
                                        keyWidth: .large)
                            }
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: "⇧", keyWidth: .extraLarge,
                                        isKeyPressed: keyLayoutObserver.currentModifiers.contains(.shift))
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[6])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[7])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[8])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[9])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[11])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[45])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[46])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[43])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[47])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[44])
                                KeyView(keyChar: "⇧", keyWidth: .extraLarge,
                                        isKeyPressed: keyLayoutObserver.currentModifiers.contains(.shift))
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .position(x: parent.frame(in: .local).midX, y: parent.frame(in: .local).midY)
                    .scaleEffect(parent.size.height / 750)
                    .transition(.opacity)
                }
            }
            .onChange(of: appState.isShowingOverlay) {
                keyLayoutObserver.eventTapEnabled = appState.isShowingOverlay
                
                withAnimation(.smooth(duration: 0.2)) {
                    showOverlay = appState.isShowingOverlay
                }
            }
        } else {
            GeometryReader { parent in
                if (showOverlay) {
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[50])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[18])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[19])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[20])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[21])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[23])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[22])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[26])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[28])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[25])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[29])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[27])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[24])
                                KeyView(keyChar: keyLayoutObserver.currentModifiers.contains(.function) ? "⌦" : "⌫",
                                        keyWidth: .medium)
                            }
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: "⇥", keyWidth: .medium)
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[12])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[13])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[14])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[15])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[17])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[16])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[32])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[34])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[31])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[35])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[33])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[30])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[42])
                            }
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: "⇪", keyWidth: .large,
                                        isKeyPressed: keyLayoutObserver.currentModifiers.contains(.capsLock))
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[0])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[1])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[2])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[3])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[5])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[4])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[38])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[40])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[37])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[41])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[39])
                                KeyView(keyChar: keyLayoutObserver.currentModifiers.contains(.function) ? "⌤" : "⏎",
                                        keyWidth: .large)
                            }
                            
                            HStack(spacing: 20) {
                                KeyView(keyChar: "⇧", keyWidth: .extraLarge,
                                        isKeyPressed: keyLayoutObserver.currentModifiers.contains(.shift))
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[6])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[7])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[8])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[9])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[11])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[45])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[46])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[43])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[47])
                                KeyView(keyChar: keyLayoutObserver.keyLayoutMap[44])
                                KeyView(keyChar: "⇧", keyWidth: .extraLarge,
                                        isKeyPressed: keyLayoutObserver.currentModifiers.contains(.shift))
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .position(x: parent.frame(in: .local).midX, y: parent.frame(in: .local).midY)
                    .scaleEffect(parent.size.height / 750)
                    .transition(.opacity)
                }
            }
            .onChange(of: appState.isShowingOverlay) { isShowingOverlay in
                keyLayoutObserver.eventTapEnabled = isShowingOverlay
                
                withAnimation(.smooth(duration: 0.2)) {
                    showOverlay = isShowingOverlay
                }
            }
        }
        
    }

}
