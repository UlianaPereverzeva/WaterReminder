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
    private var configuration = Configuration(reminders: false, from: 00, to: 00, interval: 0)
    private var lastSelectedSettingType: ReminderSettingsType = .from
    let notifications = Notifications()
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
            from: from ?? 00,
            to: to ?? 00,
            interval: interval ?? 0
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
        refreshNotifications()
        self.userDefaults.saveBool(isOn, forKey: "remindersEnabled")
        self.view?.refresh(with: self.configuration)
    }
    
    func refreshNotifications() {
        if let ids = userDefaults.getPlannedNotificationIds() {
            deleteOldNotifications(ids: ids)
        } else {
            setNewNotificationsIfNeeded()
        }
    }
    
    func deleteOldNotifications(ids: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ids)
        userDefaults.setPlannedNotificationIds(ids: nil)
        setNewNotificationsIfNeeded()
    }
    
    func setNewNotificationsIfNeeded() {
        guard configuration.reminders,
        configuration.interval > 0 else { return }
        let hours = getNotificationHours(from: configuration)
        var ids = [String]()
        for hour in hours {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Hey"
            notificationContent.body = "Let's drink water"
            notificationContent.sound = .default
            var datComp = DateComponents()
            datComp.hour = hour
            datComp.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
            let id = UUID().uuidString
            ids.append(id)
            let request = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
        }
        userDefaults.setPlannedNotificationIds(ids: ids)
    }
    
    func getNotificationHours(from config: Configuration) -> [Int] {
        guard config.from < config.to else { return [] }
        
        var result = [Int]()
        var current = config.from
        while current <= config.to {
            result.append(current)
            current += config.interval
        }
        
        return result
    }
    
    func handleSelectedTime(_ time: String) {
        guard let time = Int(time) else { return }

        switch lastSelectedSettingType {
        case .from, .to:
                if lastSelectedSettingType == .from {
                    configuration.from = time
                    userDefaults.saveTime(time, forKey: "fromTime")
                } else {
                    configuration.to = time
                    userDefaults.saveTime(time, forKey: "toTime")
                }
                self.view?.refresh(with: self.configuration)
            
        case .interval:
                configuration.interval = time
                userDefaults.saveTime(time, forKey: "intervalTime")
                self.view?.refresh(with: self.configuration)
        }
        refreshNotifications()
    }
}

class Configuration {
    var reminders: Bool
    var from: Int
    var to: Int
    var interval: Int
    
    init(reminders: Bool, from: Int, to: Int, interval: Int) {
        self.reminders = reminders
        self.from = from
        self.to = to
        self.interval = interval
    }
}
