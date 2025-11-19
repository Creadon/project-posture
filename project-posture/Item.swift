//
//  Item.swift
//  project-posture
//
//  Created by Linus Sjunnesson on 2025-11-19.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
