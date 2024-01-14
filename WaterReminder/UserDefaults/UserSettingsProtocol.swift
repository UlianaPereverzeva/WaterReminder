//
//  UserSettings.swift
//  WaterReminder
//
//  Created by ульяна on 10.01.24.
//

import Foundation
protocol UserSettings {
    func saveTime(_ time: String, forKey key: String)
    func getTime(forKey key: String) -> String?
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
}
