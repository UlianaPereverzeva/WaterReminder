//
//  File.swift
//  WaterReminder
//
//  Created by ульяна on 15.01.24.
//

import Foundation

enum ReminderSettingsType {
    case from
    case to
    case interval
}

enum Gender {
    case men
    case women
    
    var imageName: String {
        switch self {
        case .men:
            "men"
        case .women:
            "women"
        }
    }
    
    var identifier: String {
        switch self {
        case .men:
            "men"
        case .women:
            "women"
        }
    }
}

enum ActivityLevel {
    case low
    case average
    case high
    
    init?(string: String) {
        switch string {
        case "low":
            self = .low
        case "average":
            self = .average
        case "high":
            self = .high
        default:
            return nil
        }
    }
    
    var identifier: String {
        switch self {
        case .low:
            "low"
        case .average:
            "average"
        case .high:
            "high"
        }
    }
}

