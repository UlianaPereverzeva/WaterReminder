//
//  UserDefaultsManager.swift
//  WaterReminder
//
//  Created by ульяна on 10.01.24.
//

import Foundation

class UserDefaultsManager: UserSettings {
    
    let userDefaults = UserDefaults.standard
    
    func saveTime(_ time: Int, forKey key: String) {
        userDefaults.set(time, forKey: key)
    }
    
    func getTime(forKey key: String) -> Int? {
        userDefaults.integer(forKey: key)
    }
    
    func saveBool(_ value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getBool(forKey key: String) -> Bool? {
        userDefaults.bool(forKey: key)
    }
    
    func saveKg(_ kg: String, forKey key: String) {
        userDefaults.set(kg, forKey: key)
    }
    
    func getKg(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveImageIdentifier(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getImageIdentifier(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveActivityLevel(_ level: String, forKey key: String) {
        userDefaults.set(level, forKey: key)
    }
    
    func getActivityLevel(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveWaterIntake(_ intake: String, forKey key: String) {
        userDefaults.set(intake, forKey: key)
    }
    
    func getWaterIntake(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveMlGlassesDrunk(_ glasses: String, forKey key: String) {
        userDefaults.set(glasses, forKey: key)
    }
    
    func getNumberOfGlassesDrunk(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveLeftWater(_ intake: String, forKey key: String) {
        userDefaults.set(intake, forKey: key)
    }
    
    func getLeftWater(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveLastReadDate(_ date: Date) {
        let timeInterval = date.timeIntervalSince1970
        userDefaults.setValue(timeInterval, forKey: "lastReadDate")
    }
    
    func getLastReadDate() -> Date? {
        let timeInterval = userDefaults.double(forKey: "lastReadDate")
        if timeInterval == 0 {
            return nil
        }
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    func savePercentage(_ intake: String, forKey key: String){
        userDefaults.set(intake, forKey: key)
    }
    func getPercentage(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func getPlannedNotificationIds() -> [String]? {
        userDefaults.stringArray(forKey: "plannedNotifications")
    }
    
    func setPlannedNotificationIds(ids: [String]?) {
        userDefaults.setValue(ids, forKey: "plannedNotifications")
    }
}
