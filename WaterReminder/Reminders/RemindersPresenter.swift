//
//  RemindersPresenter.swift
//  WaterReminder
//
//  Created by ульяна on 5.01.24.
//

import Foundation
import UserNotifications

final class RemindersPresenter {
    weak var view: RemindersViewProtocol?
    private var configuration = Configuration(reminders: false, from: "00:00", to: "00:00", interval: "0")
    private var lastSelectedSettingType: ReminderSettingsType = .from
    internal let userDefaults: UserSettings
    
    init(userDefaults: UserSettings = UserDefaultsManager()) {
        self.userDefaults = userDefaults
        self.loadConfigurationFromUserDefaults()
    }
    
    private func loadConfigurationFromUserDefaults() {
        let reminders = userDefaults.getBool(forKey: "remindersEnabled")
        let from = userDefaults.getTime(forKey: "fromTime")
        let to = userDefaults.getTime(forKey: "toTime")
        let interval = userDefaults.getTime(forKey: "intervalTime")
        self.configuration = Configuration(
            reminders: reminders ?? false,
            from: from ?? "00:00",
            to: to ?? "00:00",
            interval: interval ?? "0"
        )
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
    
    func viewDidLoad() {
        self.view?.refresh(with: self.configuration)
    }
    
    func handleSwitchValueChanged(isOn: Bool) {
        self.configuration.reminders = isOn
        self.userDefaults.saveBool(isOn, forKey: "remindersEnabled")
        self.view?.refresh(with: self.configuration)
    }
    
//    func scheduleNotification() {
//        let center = UNUserNotificationCenter.current()
//
//            let content = UNMutableNotificationContent()
//            content.title = "Hey"
//            content.body = "Let's drink water"
//            content.sound = UNNotificationSound.default
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "HH:mm"
//
//            let fromDate = dateFormatter.date(from: configuration.from) ?? Date()
//            let toDate = dateFormatter.date(from: configuration.to) ?? Date()
//
//            var calendar = Calendar.current
//            calendar.timeZone = TimeZone.current
//
//            let fromComponents = calendar.dateComponents([.hour, .minute], from: fromDate)
//            let toComponents = calendar.dateComponents([.hour, .minute], from: toDate)
//
//            let intervalMinutes = Int(configuration.interval) ?? 0
//
//            var dateComponents = fromComponents
//
//            while let date = calendar.date(from: dateComponents), date < toDate {
//                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//                center.add(request)
//
//                if let nextDate = calendar.date(byAdding: .minute, value: intervalMinutes, to: date) {
//                    dateComponents = calendar.dateComponents([.hour, .minute], from: nextDate)
//                } else {
//                    break
//                }
//            }
//        }
    
    func handleSelectedTime(_ time: Any) {
        switch lastSelectedSettingType {
        case .from, .to:
            if let selectedTime = time as? TimeInterval {
                let hours = Int(selectedTime) / 3600
                let minutes = (Int(selectedTime) % 3600) / 60
                let formattedString = String(format: "%02d:%02d", hours, minutes)

                if lastSelectedSettingType == .from {
                    configuration.from = formattedString
                    userDefaults.saveTime(formattedString, forKey: "fromTime")
                } else {
                    configuration.to = formattedString
                    userDefaults.saveTime(formattedString, forKey: "toTime")
                }

                self.view?.refresh(with: self.configuration)
            }
        case .interval:
            if let interval = time as? String {
                configuration.interval = interval
                userDefaults.saveTime(interval, forKey: "intervalTime")
                self.view?.refresh(with: self.configuration)
            }
        }
        
        //scheduleNotification()
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
