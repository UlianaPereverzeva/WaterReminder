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
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

            let content = UNMutableNotificationContent()
            content.title = "Hey"
            content.body = "Let's drink water"
            content.sound = UNNotificationSound.default

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"

            let fromDate = dateFormatter.date(from: configuration.from) ?? Date()
            let toDate = dateFormatter.date(from: configuration.to) ?? Date()

            var calendar = Calendar.current
            calendar.timeZone = TimeZone.current

            let fromComponents = calendar.dateComponents([.hour, .minute], from: fromDate)
            let toComponents = calendar.dateComponents([.hour, .minute], from: toDate)

            let intervalMinutes = Int(configuration.interval) ?? 0

            var dateComponents = fromComponents

            while let date = calendar.date(from: dateComponents), date < toDate {
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)

                if let nextDate = calendar.date(byAdding: .minute, value: intervalMinutes, to: date) {
                    dateComponents = calendar.dateComponents([.hour, .minute], from: nextDate)
                } else {
                    break
                }
            }
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
        scheduleNotification()
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
