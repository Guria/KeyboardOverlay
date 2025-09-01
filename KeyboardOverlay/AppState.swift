//
//  AppState.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 30/08/25.
//

import SwiftUI
import KeyboardShortcuts

@MainActor
final class AppState: ObservableObject {
    
    @Published var isShowingOverlay: Bool = true
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .toggleWindow) { [self] in
            toggleWindow()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(toggleWindow), name: NSNotification.Name("toggleWindow"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("toggleWindow"), object: nil)
    }
    
    @objc func toggleWindow() {
        isShowingOverlay.toggle()
    }
}
