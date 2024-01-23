//
//  MyAccountPresenter.swift
//  WaterReminder
//
//  Created by ульяна on 13.01.24.
//

import Foundation

final class MyAccountPresenter {
    
    internal let userDefaults: UserSettings
    weak var view: MyAccountViewProtocol?
    
    init(userDefaults: UserSettings = UserDefaultsManager()) {
        self.userDefaults = userDefaults
    }
}

extension MyAccountPresenter: MyAccountPresenerProtocol {
    
    func setView(_ view: MyAccountViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        let genderId = userDefaults.getImageIdentifier(forKey: "selectedImageIdentifier")
        switch genderId {
        case "men":
            view?.setSelectedGender(gender: .men)
        case "women":
            view?.setSelectedGender(gender: .women)
        default:
            return
        }
        if let activityLevel = getActivityLevelFromUserDefaults() {
            view?.setSelectedActivityLevel(activity: activityLevel)
        }
        getWaterIntakeFromUserDefaults()
        getWeightFromUserDefaults()
    }
    
    func getWaterIntakeFromUserDefaults() {
        guard let water = userDefaults.getWaterIntake(forKey: "userWaterIntake") else { return }
        view?.updateWaterIntakeLabel("\(water) ml")
        return
    }
    
    func getWeightFromUserDefaults() {
        guard let weight = userDefaults.getKg(forKey: "userWeight") else { return }
        view?.updateWeight(weight)
        return
    }
        
    func saveButtonTapped(with weightText: String) {
        userDefaults.saveKg(weightText, forKey: "userWeight")
        refreshWaterIntake()
    }
    
    func refreshWaterIntake() {
        guard let activityLevel = getActivityLevelFromUserDefaults(),
              let weightText = userDefaults.getKg(forKey: "userWeight"),
              let activityMultiplier = getActivityMultiplier(for: activityLevel),
              let weight = Int(weightText) else {
            return
        }
        let waterIntake = weight * activityMultiplier
        userDefaults.saveWaterIntake("\(waterIntake)", forKey: "userWaterIntake")
        view?.updateWaterIntakeLabel("\(waterIntake) ml")
    }
    
    func getActivityLevelFromUserDefaults() -> ActivityLevel? {
        guard let activityLevelId = userDefaults.getActivityLevel(forKey: "selectedActivityLevel") else { return nil }
        return ActivityLevel(string: activityLevelId)
    }
    
    func getActivityMultiplier(for activityLevel: ActivityLevel) -> Int? {
        switch activityLevel {
        case .low:
            return 25
        case .average:
            return 27
        case .high:
            return 30
        }
    }
    
    func didSelectGender(gender: Gender) {
        let genderIdentifier = gender.identifier
        userDefaults.saveImageIdentifier(genderIdentifier, forKey: "selectedImageIdentifier")
        view?.setSelectedGender(gender: gender)
    }
    
    func didSelectActivityLevel(activity: ActivityLevel) {
        let activityIdentifier = activity.identifier
        userDefaults.saveActivityLevel(activityIdentifier, forKey: "selectedActivityLevel")
        view?.setSelectedActivityLevel(activity: activity)
        refreshWaterIntake()
    }
}
