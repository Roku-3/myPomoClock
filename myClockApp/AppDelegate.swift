//
//  AppDelegate.swift
//  myClockApp
//
//  Created by Ryoma Usui on 2021/01/17.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window = NSWindow.makeWindow()
//    var window = NSWindow.switchMovable()
    var hostingView: NSView?

    func applicationDidFinishLaunching(_ notification: Notification) {
      hostingView = NSHostingView(rootView: ContentView())
      window.contentView = hostingView
//      NSApp.activate(ignoringOtherApps: true)
//        NSApp.setActivationPolicy(.regular)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension NSRect {
    static func makeDefault() -> NSRect {
        let initialMargin = CGFloat(100)
        let fallback = NSRect(x: 0, y: 0, width: 300, height: 200)
        
        guard let screenFrame = NSScreen.main?.frame else {
            return fallback
        }
        
        return NSRect(
            x: screenFrame.maxX - fallback.width - initialMargin,
            y: screenFrame.maxY - fallback.height - initialMargin,
            width: fallback.width, height: fallback.height)
    }
}

extension NSWindow {
  static func makeWindow() -> NSWindow {
//    let window = NSWindow(
//      contentRect: NSRect.makeDefault(),
////      styleMask: [.closable, .miniaturizable, .resizable, .fullSizeContentView],
//        styleMask: [.closable, .miniaturizable, .resizable, .nonactivatingPanel],
//      backing: .buffered, defer: false)
    let rect = NSRect(x: 0, y: 0, width: 300, height: 200)
    let styleMask: NSWindow.StyleMask = [.closable, .resizable, .nonactivatingPanel]
    let window = NSPanel(contentRect: rect, styleMask: styleMask, backing: .buffered, defer: true)
    window.collectionBehavior = [.stationary, .ignoresCycle, .canJoinAllSpaces, .fullScreenAuxiliary]
    window.makeKeyAndOrderFront(nil)
    window.isMovableByWindowBackground = true
//    window.ignoresMouseEvents = true
    window.isMovable = true
    window.titleVisibility = .hidden
    window.setFrameAutosaveName("everclock")
    window.level = .floating
    window.backgroundColor = #colorLiteral(red: 0.1088172421, green: 0.00512934057, blue: 0.9989280105, alpha: 0)
    return window
  }

//    static func switchMovable() -> NSWindow{
//        .isMovableByWindowBackground = true
//        return window
//    }
}
