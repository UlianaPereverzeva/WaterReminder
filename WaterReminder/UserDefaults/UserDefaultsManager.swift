//
//  UserDefaultsManager.swift
//  WaterReminder
//
//  Created by ульяна on 10.01.24.
//

import Foundation

class UserDefaultsManager: UserSettings {
    
    let userDefaults = UserDefaults.standard
    
    func saveTime(_ time: String, forKey key: String) {
        userDefaults.set(time, forKey: key)
    }
    func getTime(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
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
        UserDefaults.standard.set(level, forKey: key)
    }
    
    func getActivityLevel(forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    func saveWaterIntake(_ intake: String, forKey key: String) {
        userDefaults.set(intake, forKey: key)
    }
    func getWaterIntake(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }
}
