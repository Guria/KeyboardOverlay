//
//  SettingsView.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 30/08/25.
//

import SwiftUI
import KeyboardShortcuts

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            ToggleWindowSection()
        }
        .padding(50)
    }
}

private struct ToggleWindowSection: View {
    var body: some View {
        Form {
            KeyboardShortcuts.Recorder("Toggle Keyboard Overlay", name: .toggleWindow)
        }
    }
}

extension KeyboardShortcuts.Name {
    static let toggleWindow = Self("toggleWindow")
}
