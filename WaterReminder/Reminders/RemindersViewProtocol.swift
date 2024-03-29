//
//  RemindersViewProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 5.01.24.
//

import Foundation

protocol RemindersViewProtocol: AnyObject {
    
    func refresh(with configuration: Configuration)
    func showTimePicker()
    func showIntervalPicker()
}



