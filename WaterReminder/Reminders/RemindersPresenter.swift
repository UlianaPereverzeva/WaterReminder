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
    
    func handleSelectedTime(_ timeInSeconds: TimeInterval) {
        let hours = Int(timeInSeconds) / 3600
        let minutes = (Int(timeInSeconds) % 3600) / 60
        
        let formattedString = String(format: "%02d:%02d", hours, minutes)
        
        switch lastSelectedSettingType {
                case .from:
                    configuration.from = formattedString
            view?.updateLabelInCell(value: configuration)
                case .to:
                    configuration.to = formattedString
            view?.updateLabelInCell(value: configuration)

                case .interval:
                    break
                }
        print("Selected Time: \(formattedString)")
    }
    
    func handleSelectedInterval(_ interval: String) {
        configuration.interval = interval
        view?.updateLabelInCell(value: configuration)
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
