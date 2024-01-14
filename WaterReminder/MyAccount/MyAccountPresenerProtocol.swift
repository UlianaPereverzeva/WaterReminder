//
//  MyAccountPresenerProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 13.01.24.
//

import Foundation

protocol MyAccountPresenerProtocol {
   
    func setView(_ view: MyAccountViewProtocol)
    var userDefaults: UserSettings { get }
}
