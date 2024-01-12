//
//  MyAccount.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class MyAccountViewController: UIViewController {
    
    let genderStackView = UIStackView()
    let activityLevelStackView = UIStackView()
    var selectedButton: UIButton?
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "0"
        textField.borderStyle = .roundedRect
        textField.widthAnchor.constraint(equalToConstant: 75).isActive = true
        textField.layer.cornerRadius = 28
        return textField
    }()
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
    let labelUnderMain: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Specify all parameters to calculate your\nwater consumption rate"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please indicate your gender"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your weight"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let kgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kg"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let activityLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Аctivity level"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let waterIntakeLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your daily water intake is"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let mlLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 ml"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 68, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpWeightStackView()
        setUpActivityLevelStackView()
        view.backgroundColor = .systemBlue
    }
    
    func setUpWeightStackView() {
        genderStackView.axis = .horizontal
        genderStackView.spacing = 25
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let menButton = makeButton(imageName: "men")
        genderStackView.addArrangedSubview(menButton)
        
        let womenButton = makeButton(imageName: "women")
        genderStackView.addArrangedSubview(womenButton)
        
    }
    
    func setUpActivityLevelStackView() {
        activityLevelStackView.axis = .horizontal
        activityLevelStackView.spacing = 8
        activityLevelStackView.alignment = .fill
        activityLevelStackView.distribution = .fillEqually
        activityLevelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let lowButton = activityLevelButton(title: "Low", backgroundColor: .white, titleColor: .systemBlue)
        let averageButton = activityLevelButton(title: "Аverage", backgroundColor: .white, titleColor: .systemBlue)
        let highButton = activityLevelButton(title: "High", backgroundColor: .white, titleColor: .systemBlue)
        
        activityLevelStackView.addArrangedSubview(lowButton)
        activityLevelStackView.addArrangedSubview(averageButton)
        activityLevelStackView.addArrangedSubview(highButton)
    }
    
    func setUpConstraints() {
        view.addSubview(mainLabelWaterIntake)
        view.addSubview(labelUnderMain)
        view.addSubview(genderLabel)
        view.addSubview(genderStackView)
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        view.addSubview(kgLabel)
        view.addSubview(activityLevelLabel)
        view.addSubview(activityLevelStackView)
        view.addSubview(waterIntakeLevelLabel)
        view.addSubview(mlLevelLabel)


        mainLabelWaterIntake.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        mainLabelWaterIntake.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelUnderMain.topAnchor.constraint(equalTo: mainLabelWaterIntake.bottomAnchor, constant: 6).isActive = true
        labelUnderMain.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        genderLabel.topAnchor.constraint(equalTo: labelUnderMain.bottomAnchor, constant: 36).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        
        genderStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        genderStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 14).isActive = true
        genderStackView.heightAnchor.constraint(equalToConstant: 164).isActive = true
        
        weightLabel.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 26).isActive = true
        weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        
        weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 14).isActive = true
        weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        
        kgLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 20).isActive = true
        kgLabel.leadingAnchor.constraint(equalTo: weightTextField.trailingAnchor, constant: 10).isActive = true
        
        activityLevelLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 26).isActive = true
        activityLevelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        
        activityLevelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityLevelStackView.topAnchor.constraint(equalTo: activityLevelLabel.bottomAnchor, constant: 14).isActive = true
        activityLevelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        activityLevelStackView.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        waterIntakeLevelLabel.topAnchor.constraint(equalTo: activityLevelStackView.bottomAnchor, constant: 26).isActive = true
        waterIntakeLevelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        
        mlLevelLabel.topAnchor.constraint(equalTo: waterIntakeLevelLabel.bottomAnchor, constant: 26).isActive = true
        mlLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
    }
    
    func makeButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .normal)
        }
        let imageSize = CGSize(width: 137, height: 164)
        button.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        button.addTarget(self, action: #selector(buttonGenderTapped), for: .touchUpInside)
        
        return button
    }
    
    func activityLevelButton(title: String, backgroundColor: UIColor, titleColor: UIColor) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(titleColor, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 8  // закругление углов
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)

            return button
        }
    
    @objc func buttonGenderTapped(sender: UIButton) {
        selectedButton?.layer.borderWidth = 0.0
        sender.layer.borderWidth = 5.0
        sender.layer.cornerRadius = 28
        sender.layer.borderColor = CGColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00)
        selectedButton = sender
    }
}
