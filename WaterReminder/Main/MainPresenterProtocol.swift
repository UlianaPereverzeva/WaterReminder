//
//  MainViewControllerPresenerProtocol.swift
//  WaterReminder
//
//  Created by ульяна on 16.01.24.
//

import Foundation

protocol MainPresenterProtocol {
    func setView(_ view: MainViewProtocol)
    func viewDidLoad()
    func viewWillAppear()
    var userDefaults: UserSettings { get }
    func didSelectNumberOfGlassesDrunk(glasses: NumberOfGlassesDrunk)
    func refreshWaterIntake()
    var currentProgress: CGFloat { get set }
    func getStateOfProgressBar()
}
