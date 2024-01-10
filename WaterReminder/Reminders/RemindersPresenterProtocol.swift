//
//  RemindersPresenterProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 5.01.24.
//

import Foundation
 
protocol RemindersPresenterProtocol {
    
    func setView(_ view: RemindersViewProtocol)
    func didSelectSettingsType(type: ReminderSettingsType) 
    func handleSelectedTime(_ timeInSeconds: TimeInterval)
    func handleSelectedInterval(_ interval: String)
}

