//
//  MotionSample.swift
//  project-posture
//
//  Created by Linus Sjunnesson on 2025-11-26.
//

import Foundation
import SwiftData

@Model
final class MotionSample {
    var timestamp: Date
    var roll: Double
    var pitch: Double
    var yaw: Double
    var accelerationX: Double
    var accelerationY: Double
    var accelerationZ: Double

    init(timestamp: Date = .now,
         roll: Double,
         pitch: Double,
         yaw: Double,
         accelerationX: Double,
         accelerationY: Double,
         accelerationZ: Double) {
        self.timestamp = timestamp
        self.roll = roll
        self.pitch = pitch
        self.yaw = yaw
        self.accelerationX = accelerationX
        self.accelerationY = accelerationY
        self.accelerationZ = accelerationZ
    }
}
