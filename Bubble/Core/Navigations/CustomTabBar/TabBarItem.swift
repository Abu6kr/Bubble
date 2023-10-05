//
//  TabBarItem.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/6/21.
//

import Foundation
import SwiftUI


enum TabBarItem: Hashable {
    case home, map, profile, messages
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .map: return "map.fill"
        case .profile: return "person.fill"
        case .messages: return "message.badge.filled.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .map: return "Map"
        case .profile: return "Profile"
        case .messages: return "Messages"
        }
    }
}

