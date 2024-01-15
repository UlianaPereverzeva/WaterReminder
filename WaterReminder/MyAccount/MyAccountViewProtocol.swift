//
//  MyAccountViewProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 13.01.24.
//

import Foundation

protocol MyAccountViewProtocol: AnyObject {
//    func updateSelectedButton(_ button: UIButton)
    func updateWaterIntakeLabel(_ text: String)
    func setSelectedGender(gender: Gender)
    func setSelectedActivityLevel(activity: ActivityLevel)
    func updateWeight(_ text: String)
    
}
