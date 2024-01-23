//
//  MainViewControllerPresener.swift
//  WaterReminder
//
//  Created by ульяна on 16.01.24.
//

import Foundation
import UIKit.UIApplication

final class MainPresenter {
    
    var currentProgress: CGFloat = 0
    internal let userDefaults: UserSettings
    weak var view: MainViewProtocol?
    
    init(userDefaults: UserSettings = UserDefaultsManager()) {
        self.userDefaults = userDefaults
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    @objc func applicationDidBecomeActive() {
        getWaterIntakeFromUserDefaults()
        view?.updateCircularProgressBar(progress: currentProgress)
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func setView(_ view: MainViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        getWaterForSetUpCircularProgressBar()
        getStateOfProgressBar()
    }
    
    func viewWillAppear() {
        getWaterIntakeFromUserDefaults()
    }
    
    func didSelectNumberOfGlassesDrunk(glasses: NumberOfGlassesDrunk) {
        
        let glassesIdentifier = glasses.identifier
        userDefaults.saveMlGlassesDrunk(glassesIdentifier, forKey: "selectedNumberOfGlassesDrunk")
        view?.setSelectedNumberOfGlassesDrunk(glasses: glasses)
        
        let waterIntake = userDefaults.getWaterIntake(forKey: "userWaterIntake")
        let leftWater = userDefaults.getLeftWater(forKey: "leftWater")
        guard let waterIntake = Int(waterIntake ?? "0"),
              let glassesIdentifier = Int(glassesIdentifier),
              let leftWater = Int(leftWater ?? "0") else { return }
        if waterIntake == leftWater {
            var leftWater = waterIntake - glassesIdentifier
            if leftWater < 0 {
                leftWater = 0
            }
            userDefaults.saveLeftWater(String(leftWater), forKey: "leftWater")
            view?.updateWaterIntakeLabel("\(leftWater) ml")
        } else {
            var leftWater = leftWater - glassesIdentifier
            if leftWater < 0 {
                leftWater = 0
            }
            userDefaults.saveLeftWater(String(leftWater), forKey: "leftWater")
            view?.updateWaterIntakeLabel("\(leftWater) ml")
        }
        calculateCurrentProgress(glassesIdentifier: glassesIdentifier, waterIntake: waterIntake)
    }
    
    func calculateCurrentProgress(glassesIdentifier: Int, waterIntake: Int) {
        
        currentProgress += CGFloat(glassesIdentifier) / CGFloat(waterIntake)
        currentProgress = min(currentProgress, 1)
        userDefaults.savePercentage(String(describing: currentProgress), forKey: "percentage")
        view?.updateCircularProgressBar(progress: currentProgress)
    }

    func getWaterIntakeFromUserDefaults() {
        
        if let leftWater = userDefaults.getLeftWater(forKey: "leftWater") {
            if let lastReadDate = userDefaults.getLastReadDate() {
                if Calendar.current.isDate(lastReadDate, inSameDayAs: Date()) {
                    view?.updateWaterIntakeLabel("\(leftWater) ml")
                } else if let waterIntake = userDefaults.getWaterIntake(forKey: "userWaterIntake") {
                    userDefaults.saveLeftWater(waterIntake, forKey: "leftWater")
                    view?.updateWaterIntakeLabel("\(waterIntake) ml")
                }
            } else {
                view?.updateWaterIntakeLabel("\(leftWater) ml")
            }
            
            let newLastReadDate = Date()
            userDefaults.saveLastReadDate(newLastReadDate)
            
        } else if let waterIntake = userDefaults.getWaterIntake(forKey: "userWaterIntake") {
            userDefaults.saveLeftWater(waterIntake, forKey: "leftWater")
            view?.updateWaterIntakeLabel("\(waterIntake) ml")
        }
    }
    
    func refreshWaterIntake() {
        
        guard let waterIntake = userDefaults.getWaterIntake(forKey: "userWaterIntake")  else { return }
        view?.updateWaterIntakeLabel("\(waterIntake) ml")
    }
    
    func getStateOfProgressBar() {
        
        if let savedProgressString = userDefaults.getPercentage(forKey: "percentage"),
           let savedProgress = Double(savedProgressString) {
            let progress = CGFloat(savedProgress)
            view?.updateCircularProgressBar(progress: progress)
            currentProgress = progress
        }
    }
    
    func getWaterForSetUpCircularProgressBar() {
        if let waterIntake = userDefaults.getWaterIntake(forKey: "userWaterIntake") {
            guard let waterIntake = Int(waterIntake) else { return }
            view?.setUpCircularProgressBar(waterIntake: waterIntake)
        }
    }
}
