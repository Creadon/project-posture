//
//  AppDelegate.swift
//  project-posture
//
//  Created by Linus Sjunnesson on 2025-11-19.
//

import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    var sniffer: HeadphoneMotionSniffer?

    func applicationWillTerminate(_ notification: Notification) {
        print("App is terminating — stopping sniffer.")
        sniffer?.stopSniffing()
    }
}
