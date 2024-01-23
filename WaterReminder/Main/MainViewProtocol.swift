//
//  MainViewControllerViewProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 16.01.24.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func setSelectedNumberOfGlassesDrunk(glasses: NumberOfGlassesDrunk)
    func updateWaterIntakeLabel(_ text: String)
    func updateCircularProgressBar(progress: CGFloat)
    func setUpCircularProgressBar(waterIntake: Int)
}
