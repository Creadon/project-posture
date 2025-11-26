//
//  MotionSnifferProtocol.swift
//  project-posture
//
//  Created by Linus Sjunnesson on 2025-11-26.
//

import Combine

protocol MotionSnifferProtocol: ObservableObject {
    var roll: Double { get }
    var pitch: Double { get }
    var yaw: Double { get }
    var accelerationX: Double { get }
    var accelerationY: Double { get }
    var accelerationZ: Double { get }
    
    func startSniffing()
    func stopSniffing()
}
