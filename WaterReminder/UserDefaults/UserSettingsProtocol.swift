//
//  UserSettings.swift
//  WaterReminder
//
//  Created by ульяна on 10.01.24.
//

import Foundation
protocol UserSettings {
    func saveTime(_ time: Int, forKey key: String)
    func getTime(forKey key: String) -> Int?
    func saveBool(_ value: Bool, forKey key: String)
    func getBool(forKey key: String) -> Bool?
    func saveKg(_ time: String, forKey key: String)
    func getKg(forKey key: String) -> String?
    func saveImageIdentifier(_ value: String, forKey key: String)
    func getImageIdentifier(forKey key: String) -> String?
    func saveActivityLevel(_ level: String, forKey key: String)
    func getActivityLevel(forKey key: String) -> String?
    func saveWaterIntake(_ intake: String, forKey key: String)
    func getWaterIntake(forKey key: String) -> String?
    func saveMlGlassesDrunk(_ glasses: String, forKey key: String)
    func getNumberOfGlassesDrunk(forKey key: String) -> String?
    func saveLeftWater(_ intake: String, forKey key: String)
    func getLeftWater(forKey key: String) -> String?
    func saveLastReadDate(_ date: Date)
    func getLastReadDate() -> Date?
    func savePercentage(_ intake: String, forKey key: String)
    func getPercentage(forKey key: String) -> String?
    
    func getPlannedNotificationIds() -> [String]?
    func setPlannedNotificationIds(ids: [String]?)
}
