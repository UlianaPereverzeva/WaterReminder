//
//  MyAccount.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class MyAccountViewController: UIViewController {
    
    private var presenter: MyAccountPresenerProtocol = MyAccountPresenter()
    
    let genderStackView = UIStackView()
    let activityLevelStackView = UIStackView()
    var menButton: UIButton?
    var womenButton: UIButton?
    var lowButton: UIButton?
    var averageButton: UIButton?
    var highButton: UIButton?
    
    
    
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
        setUpGenderStackView()
        setUpActivityLevelStackView()
        weightTextField.keyboardType = .numberPad
        weightTextField.inputAccessoryView = createToolbar()
        weightTextField.delegate = self
        self.presenter.setView(self)
        self.presenter.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
    
    func setUpGenderStackView() {
        genderStackView.axis = .horizontal
        genderStackView.spacing = 25
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let menButton = makeGenderButton(gender: Gender.men)
        genderStackView.addArrangedSubview(menButton)
        self.menButton = menButton
        
        let womenButton = makeGenderButton(gender: Gender.women)
        genderStackView.addArrangedSubview(womenButton)
        self.womenButton = womenButton
    }
    
    func setUpActivityLevelStackView() {
        activityLevelStackView.axis = .horizontal
        activityLevelStackView.spacing = 8
        activityLevelStackView.alignment = .fill
        activityLevelStackView.distribution = .fillEqually
        activityLevelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let lowButton = makeActivityLevelButton(title: "Low", backgroundColor: .white, titleColor: .systemBlue, identifier: "low")
        self.lowButton = lowButton
        let averageButton = makeActivityLevelButton(title: "Аverage", backgroundColor: .white, titleColor: .systemBlue, identifier: "average")
        self.averageButton = averageButton
        let highButton = makeActivityLevelButton(title: "High", backgroundColor: .white, titleColor: .systemBlue, identifier: "high")
        self.highButton = highButton
        
        
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
    
    func makeGenderButton(gender: Gender) -> UIButton {
        let button = UIButton(type: .custom)
        button.accessibilityIdentifier = gender.identifier
        
        if let image = UIImage(named: gender.imageName) {
            button.setImage(image, for: .normal)
        }
        let imageSize = CGSize(width: 137, height: 164)
        button.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        button.addTarget(self, action: #selector(buttonGenderTapped), for: .touchUpInside)
        
        return button
    }
    
    @objc func buttonGenderTapped(sender: UIButton) {
        if sender.accessibilityIdentifier == Gender.men.identifier {
            presenter.didSelectGender(gender: .men)
        } else if sender.accessibilityIdentifier == Gender.women.identifier {
            presenter.didSelectGender(gender: .women)
        }
    }
    
    @objc func saveButtonTapped() {
        view.endEditing(true)
        if let text = weightTextField.text {
            presenter.saveButtonTapped(with: text)
        }
    }
    
    func makeActivityLevelButton(title: String, backgroundColor: UIColor, titleColor: UIColor, identifier: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.accessibilityIdentifier = identifier
        button.addTarget(self, action: #selector(activityLevelButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func activityLevelButtonTapped(sender: UIButton) {
        
        if sender.accessibilityIdentifier == ActivityLevel.low.identifier {
            presenter.didSelectActivityLevel(activity: .low)
        } else if sender.accessibilityIdentifier == ActivityLevel.average.identifier {
            presenter.didSelectActivityLevel(activity: .average)
        } else if sender.accessibilityIdentifier == ActivityLevel.high.identifier {
            presenter.didSelectActivityLevel(activity: .high)
        }
    }
    
    func setupGenderButton(button: UIButton?, selected: Bool) {
        button?.layer.borderWidth = 0.0
        button?.layer.borderWidth = selected ? 5.0 : 0.0
        button?.layer.cornerRadius = selected ? 28 : 0
        button?.layer.borderColor = selected ? CGColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00) : .none
    }
    func setupActivityLevelButton(button: UIButton?, selected: Bool) {
        button?.layer.borderWidth = 0.0
        button?.layer.borderWidth = selected ? 5.0 : 0.0
        button?.layer.cornerRadius = 8
        button?.layer.borderColor = selected ? CGColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00) : .none
    }
}

extension MyAccountViewController: MyAccountViewProtocol {
    
    func updateWaterIntakeLabel(_ text: String) {
        mlLevelLabel.text = text
    }
    
    func updateWeight(_ text: String) {
        weightTextField.text = text
    }
    
    func setSelectedGender(gender: Gender) {
        
        switch gender {
        case .men:
            self.setupGenderButton(button: self.menButton, selected: true)
            self.setupGenderButton(button: self.womenButton, selected: false)
        case .women:
            self.setupGenderButton(button: self.menButton, selected: false)
            self.setupGenderButton(button: self.womenButton, selected: true)
        }
    }
    
    func setSelectedActivityLevel(activity: ActivityLevel) {
        switch activity {
        case .low:
            self.setupActivityLevelButton(button: self.lowButton , selected: true)
            self.setupActivityLevelButton(button: self.averageButton , selected: false)
            self.setupActivityLevelButton(button: self.highButton , selected: false)
        case .average:
            self.setupActivityLevelButton(button: self.averageButton, selected: true)
            self.setupActivityLevelButton(button: self.lowButton , selected: false)
            self.setupActivityLevelButton(button: self.highButton , selected: false)
        case .high:
            self.setupActivityLevelButton(button: self.highButton, selected: true)
            self.setupActivityLevelButton(button: self.averageButton, selected: false)
            self.setupActivityLevelButton(button: self.lowButton , selected: false)
        }
    }
}

extension MyAccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, saveButton], animated: false)
        
        return toolbar
    }
}
