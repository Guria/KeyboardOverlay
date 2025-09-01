//
//  AppDelegate.swift
//  KeyboardOverlay
//
//  Created by zorth64 on 26/08/25.
//

import SwiftUI
import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow?
    var settingsWindow: NSWindow?
    
    var statusItem: NSStatusItem?
    
    var eventTap: CFMachPort!
    
    @IBOutlet weak var menu: NSMenu?
    @IBOutlet weak var menuItem: NSMenuItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let accessEnabled = AXIsProcessTrustedWithOptions(
                    [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)

        if !accessEnabled {
            print("Access Not Enabled")
        }
        
        eventTap = CGEvent.tapCreate(tap: .cghidEventTap, place: .headInsertEventTap, options: .defaultTap, eventsOfInterest: 1 << CGEventType.flagsChanged.rawValue, callback: myCGEventCallback, userInfo: nil)!
        
        let runLoopSource:CFRunLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
        
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, CFRunLoopMode.commonModes);
        CGEvent.tapEnable(tap: eventTap, enable: true);
        
        CFRunLoopRun();
        
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: NSScreen.main!.frame.width, height: 450),
            styleMask: [.fullSizeContentView],
            backing: .buffered,
            defer: false)
                
        window!.titleVisibility = .hidden
        window!.titlebarAppearsTransparent = true
        window!.level = .floating
        window!.styleMask = [.fullSizeContentView, .borderless]
        window!.isMovableByWindowBackground = false
        window!.collectionBehavior = [.canJoinAllSpaces, .fullScreenDisallowsTiling]
        window!.isReleasedWhenClosed = true
        window!.isOpaque = true
        window!.backgroundColor = .clear
        window!.alphaValue = 0.0
        window!.hasShadow = false
        window!.ignoresMouseEvents = true

        let contentView = KeyboardOverlayView()
            .ignoresSafeArea(.all)

        window!.contentView = NSHostingView(rootView: contentView)
        
        window!.orderFrontRegardless()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.window?.alphaValue = 1.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let image = NSImage(systemSymbolName: "keyboard.macwindow", accessibilityDescription: nil) {
            
            var config = NSImage.SymbolConfiguration(textStyle: .body,
                                                     scale: .medium)
            config = config.applying(.init(pointSize: 15.0, weight: NSFont.Weight.regular))
            statusItem?.button?.image = image.withSymbolConfiguration(config)
        }
        
        if let menu = menu {
            statusItem?.menu = menu
        }
        if let menuItem = menuItem {
            Task { @MainActor in
                menuItem.setShortcut(for: .toggleWindow)
            }
        }
    }
    
    @IBAction func showSettingsWindow(_ sender: Any?) {
        if settingsWindow == nil {
            let settingsView = SettingsView()
            settingsWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 450, height: 340),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            settingsWindow?.level = .floating
            settingsWindow?.collectionBehavior = .canJoinAllSpaces
            settingsWindow?.center()
            settingsWindow?.title = "Keyboard Overlay Settings"
            settingsWindow?.isReleasedWhenClosed = false
            settingsWindow?.miniaturize(nil)
            settingsWindow?.zoom(nil)
            settingsWindow?.contentView = NSHostingView(rootView: settingsView)
        }

        settingsWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction func toggleWindow(_ sender: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleWindow"), object: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}

func myCGEventCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    if (type != .keyDown) {
        if (type != .keyUp) {
            if (type != .flagsChanged) {
                return Unmanaged.passRetained(event)
            }
        }
    }
    
    let flags = NSEvent.ModifierFlags(rawValue: UInt(event.flags.rawValue))
    
    NotificationCenter.default.post(name: NSNotification.Name("modifierChanged"), object: flags)
    
    return Unmanaged.passRetained(event)
}

