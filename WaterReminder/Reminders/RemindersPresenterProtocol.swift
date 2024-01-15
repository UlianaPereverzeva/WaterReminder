//
//  RemindersPresenterProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 5.01.24.
//

import Foundation
 
protocol RemindersPresenterProtocol {
    
    func setView(_ view: RemindersViewProtocol)
    func viewDidLoad()
    func didSelectSettingsType(type: ReminderSettingsType)
    func handleSelectedTime(_ time: Any)
    func handleSwitchValueChanged(isOn: Bool)
    var userDefaults: UserSettings { get }
    //func scheduleNotification()
}

