//
//  Main.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class MainViewController: UIViewController {

    let mainLabelWaterIntake: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Water intake"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        view.backgroundColor = .systemBlue
    }
  
    func setUpConstraints() {
        view.addSubview(mainLabelWaterIntake)
        
        mainLabelWaterIntake.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        mainLabelWaterIntake.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
