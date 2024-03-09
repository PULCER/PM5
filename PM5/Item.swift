//
//  Item.swift
//  PM5
//
//  Created by Anthony Howell on 3/8/24.
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
