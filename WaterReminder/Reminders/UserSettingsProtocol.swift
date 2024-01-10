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
}
