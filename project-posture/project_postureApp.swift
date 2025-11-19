//
//  project_postureApp.swift
//  project-posture
//
//  Created by Linus Sjunnesson on 2025-11-19.
//

import SwiftUI
import SwiftData

@main
struct project_postureApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    private var sniffer = HeadphoneMotionSniffer()
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    init() {
        appDelegate.sniffer = sniffer
        sniffer.startSniffing()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sniffer)
        }
        .modelContainer(sharedModelContainer)
    }
}
