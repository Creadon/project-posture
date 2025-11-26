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
    static let sharedModelContainer: ModelContainer = {
        let schema = Schema([MotionSample.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [config])
    }()
    
    private let modelContext: ModelContext
    private let sniffer: HeadphoneMotionSniffer
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    init() {
        modelContext = ModelContext(Self.sharedModelContainer)
        sniffer = HeadphoneMotionSniffer(context: modelContext)
        appDelegate.sniffer = sniffer
        sniffer.startSniffing()
    }

    var body: some Scene {
        WindowGroup {
            ContentView<HeadphoneMotionSniffer>()
                .environmentObject(sniffer)
        }
        .modelContainer(Self.sharedModelContainer)
    }
}
