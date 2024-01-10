//
//  RemindersViewProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 5.01.24.
//

import Foundation

protocol RemindersViewProtocol: AnyObject {
    func showTimePicker()
    func showIntervalPicker()
    func updateLabelInCell(value: Configuration)
    //func switchCellValueChanged(_ cell: SwitchTableViewCell, isOn: Bool)
    
}



