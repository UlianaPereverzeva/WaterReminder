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
}
