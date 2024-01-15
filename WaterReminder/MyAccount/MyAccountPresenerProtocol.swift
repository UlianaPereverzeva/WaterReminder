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
   // func handleGenderButtonTapped(_ button: UIButton)
    func saveButtonTapped(with weightText: String)
    //func handleActivityLevelButtonTapped(_ button: UIButton)
    func didSelectGender(gender: Gender)
    func didSelectActivityLevel(activity: ActivityLevel)
    func viewDidLoad()
}
