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
        return userDefaults.string(forKey: key)
    }
}
