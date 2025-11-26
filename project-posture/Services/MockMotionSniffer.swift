//
//  MockMotionSniffer.swift
//  project-posture
//
//  Created by Linus Sjunnesson on 2025-11-26.
//

import Combine

final class MockMotionSniffer: MotionSnifferProtocol {
    @Published var roll: Double = 0.1
    @Published var pitch: Double = 0.2
    @Published var yaw: Double = 0.3

    @Published var accelerationX: Double = 0.01
    @Published var accelerationY: Double = -0.02
    @Published var accelerationZ: Double = 0.98

    func startSniffing() {}
    func stopSniffing() {}
}
