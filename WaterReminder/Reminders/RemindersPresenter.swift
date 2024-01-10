//
//  RemindersPresenter.swift
//  WaterReminder
//
//  Created by ульяна on 5.01.24.
//

import Foundation

final class RemindersPresenter {
    weak var view: RemindersViewProtocol?
    private var configuration = Configuration(reminders: false, from: "00:00", to: "00:00", interval: "0")
    private var lastSelectedSettingType: ReminderSettingsType = .from
    internal let userDefaults: UserSettings
    
    init(userDefaults: UserSettings = UserDefaultsManager()) {
        self.userDefaults = userDefaults
    }
}

extension RemindersPresenter: RemindersPresenterProtocol {
    
    func didSelectSettingsType(type: ReminderSettingsType) {
        switch type {
        case .from:
            view?.showTimePicker()
        case .to:
            view?.showTimePicker()
        case .interval:
            view?.showIntervalPicker()
        }
        self.lastSelectedSettingType = type
    }
    
    func setView(_ view: RemindersViewProtocol) {
        self.view = view
    }
    
    func handleSelectedTime(_ time: Any) {
        switch lastSelectedSettingType {
        case .from:
            if let selectedTime = time as? TimeInterval {
                let hours = Int(selectedTime) / 3600
                let minutes = (Int(selectedTime) % 3600) / 60
                let formattedString = String(format: "%02d:%02d", hours, minutes)
                configuration.from = formattedString
                userDefaults.saveTime(formattedString, forKey: "fromTime")
                view?.updateLabelInCell(value: configuration)
            }
        case .to:
            if let selectedTime = time as? TimeInterval {
                let hours = Int(selectedTime) / 3600
                let minutes = (Int(selectedTime) % 3600) / 60
                let formattedString = String(format: "%02d:%02d", hours, minutes)
                configuration.to = formattedString
                userDefaults.saveTime(formattedString, forKey: "toTime")
                view?.updateLabelInCell(value: configuration)
            }
        case .interval:
            if let interval = time as? String {
                configuration.interval = interval
                userDefaults.saveTime(interval, forKey: "intervalTime")
                view?.updateLabelInCell(value: configuration)
            }
        }
    }
}

class Configuration {
    var reminders: Bool
    var from: String
    var to: String
    var interval: String
    
    init(reminders: Bool, from: String, to: String, interval: String) {
        self.reminders = reminders
        self.from = from
        self.to = to
        self.interval = interval
    }
}
