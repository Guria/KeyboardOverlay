//
//  KeyboardLayoutObserver.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 27/08/25.
//

import Foundation
import Cocoa
import Carbon
import Combine

class KeyboardLayoutObserver: ObservableObject {
    
    @Published var keyLayoutMap: [UInt16: String] = [:]
    
    @Published var currentModifiers: NSEvent.ModifierFlags = []
    
    private var observer: NSObjectProtocol?
    
    @Published var eventTapEnabled: Bool = true
    
    init() {
        updateKeyboardLayoutMap()
        startObservingChanges()
    }
    
    deinit {
        stopObservingChanges()
    }
    
    private func startObservingChanges() {
        observer = DistributedNotificationCenter.default.addObserver(
            forName: NSNotification.Name(kTISNotifySelectedKeyboardInputSourceChanged as String),
            object: nil,
            queue: .current
        ) { [weak self] _ in
            self?.updateKeyboardLayoutMap()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("modifierChanged"), object: nil, queue: .main) { notification in
            if (self.eventTapEnabled) {
                if let modifierFlags = notification.object as? NSEvent.ModifierFlags {
                    self.currentModifiers = modifierFlags
                    self.updateKeyboardLayoutMap(modifiers: self.currentModifiers)
                }
            }
        }
    }
    
    private func updateKeyboardLayoutMap(modifiers: NSEvent.ModifierFlags = []) {
        if let layoutName = KeyLayoutUtil.getCurrentKeyboardLayoutName() {

            let keyState = carbonModifierFlags(from: modifiers)
            
            if let layoutMap = KeyLayoutUtil.buildKeyLayoutMap(forLayoutName: layoutName, modifierKeyState: keyState) {
                DispatchQueue.main.async {
                    self.keyLayoutMap = layoutMap
                }
            }
        }
    }
    
    private func stopObservingChanges() {
        if let observer = observer {
            DistributedNotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func carbonModifierFlags(from flags: NSEvent.ModifierFlags) -> UInt32 {
        var result: UInt32 = 0
        if flags.contains(.shift) {
            result |= UInt32(shiftKey)
        }
        if flags.contains(.option) {
            result |= UInt32(optionKey)
        }
        if flags.contains(.capsLock) {
            result |= UInt32(alphaLock)
        }
        return result
    }
}
