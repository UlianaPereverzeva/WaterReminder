//
//  Main.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var presenter: MainPresenterProtocol = MainPresenter()
    let numberOfGlassesDrunkStackView = UIStackView()
    var smallGlassButton: UIButton?
    var mediumGlassButton: UIButton?
    var bigGlassButton: UIButton?
    let viewForProgressBar = UIView()
    var circularProgressBar: CircularProgressBar?
    
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
    
    let drunkWaterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "How much water did you drink?"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let mlLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please\nfill in your details\nin MyAccount to see\nhow much water\nyou have left\nto drink today"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpNumberOfGlassesDrunkStackView()
        setUpView()
        self.presenter.setView(self)
        self.presenter.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
  
    private func setUpConstraints() {
        view.addSubview(mainLabelWaterIntake)
        view.addSubview(drunkWaterLabel)
        view.addSubview(numberOfGlassesDrunkStackView)
        view.addSubview(mlLevelLabel)
        view.addSubview(viewForProgressBar)

        mainLabelWaterIntake.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        mainLabelWaterIntake.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        drunkWaterLabel.topAnchor.constraint(equalTo: mainLabelWaterIntake.bottomAnchor, constant: 40).isActive = true
        drunkWaterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        
        numberOfGlassesDrunkStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberOfGlassesDrunkStackView.topAnchor.constraint(equalTo: drunkWaterLabel.bottomAnchor, constant: 16).isActive = true
        numberOfGlassesDrunkStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        numberOfGlassesDrunkStackView.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        mlLevelLabel.topAnchor.constraint(equalTo: numberOfGlassesDrunkStackView.bottomAnchor, constant: 60).isActive = true
        mlLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        viewForProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewForProgressBar.topAnchor.constraint(equalTo: mlLevelLabel.bottomAnchor, constant: 40).isActive = true
        viewForProgressBar.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        viewForProgressBar.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
    }
    
    private func setUpView() {
        viewForProgressBar.translatesAutoresizingMaskIntoConstraints = false
        viewForProgressBar.backgroundColor = UIColor.clear
    }
    
    private func setUpNumberOfGlassesDrunkStackView() {
        numberOfGlassesDrunkStackView.axis = .horizontal
        numberOfGlassesDrunkStackView.spacing = 8
        numberOfGlassesDrunkStackView.alignment = .fill
        numberOfGlassesDrunkStackView.distribution = .fillEqually
        numberOfGlassesDrunkStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let smallGlassButton = makeNumberOfGlassesDrunkButton(title:"100ml", backgroundColor: .white, titleColor: .systemBlue, identifier: "100")
        self.smallGlassButton = smallGlassButton
        let mediumGlassButton = makeNumberOfGlassesDrunkButton(title: "\(NumberOfGlassesDrunk.medium.identifier)ml", backgroundColor: .white, titleColor: .systemBlue, identifier: "250")
        self.mediumGlassButton = mediumGlassButton
        let bigGlassButton = makeNumberOfGlassesDrunkButton(title: "\(NumberOfGlassesDrunk.big.identifier)ml", backgroundColor: .white, titleColor: .systemBlue, identifier: "350")
        self.bigGlassButton = bigGlassButton
        
        numberOfGlassesDrunkStackView.addArrangedSubview(smallGlassButton)
        numberOfGlassesDrunkStackView.addArrangedSubview(mediumGlassButton)
        numberOfGlassesDrunkStackView.addArrangedSubview(bigGlassButton)
    }
    
    private func makeNumberOfGlassesDrunkButton(title: String, backgroundColor: UIColor, titleColor: UIColor, identifier: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.accessibilityIdentifier = identifier
        button.addTarget(self, action: #selector(numberOfGlassesDrunkButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func numberOfGlassesDrunkButtonTapped(sender: UIButton) {

        if sender.accessibilityIdentifier == NumberOfGlassesDrunk.small.identifier {
            presenter.didSelectNumberOfGlassesDrunk(glasses: .small)
        } else if sender.accessibilityIdentifier == NumberOfGlassesDrunk.medium.identifier {
            presenter.didSelectNumberOfGlassesDrunk(glasses: .medium)
        } else if sender.accessibilityIdentifier == NumberOfGlassesDrunk.big.identifier {
            presenter.didSelectNumberOfGlassesDrunk(glasses: .big)
        }
    }
    
    private func setupNumberOfGlassesDrunkButton(button: UIButton?, selected: Bool) {
        button?.layer.borderWidth = 0.0
        button?.layer.borderWidth = selected ? 5.0 : 0.0
        button?.layer.cornerRadius = 8
        button?.layer.borderColor = selected ? CGColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00) : .none
    }
}

extension MainViewController: MainViewProtocol {
    
    func updateCircularProgressBar(progress: CGFloat) {
            circularProgressBar?.progress = progress
        }
    
    func setSelectedNumberOfGlassesDrunk(glasses: NumberOfGlassesDrunk) {
        switch glasses {
        case .small:
            self.setupNumberOfGlassesDrunkButton(button: self.smallGlassButton , selected: true)
            self.setupNumberOfGlassesDrunkButton(button: self.mediumGlassButton , selected: false)
            self.setupNumberOfGlassesDrunkButton(button: self.bigGlassButton , selected: false)
        case .medium:
            self.setupNumberOfGlassesDrunkButton(button: self.mediumGlassButton, selected: true)
            self.setupNumberOfGlassesDrunkButton(button: self.smallGlassButton , selected: false)
            self.setupNumberOfGlassesDrunkButton(button: self.bigGlassButton , selected: false)
        case .big:
            self.setupNumberOfGlassesDrunkButton(button: self.bigGlassButton, selected: true)
            self.setupNumberOfGlassesDrunkButton(button: self.mediumGlassButton, selected: false)
            self.setupNumberOfGlassesDrunkButton(button: self.smallGlassButton , selected: false)
        }
    }
    
    func updateWaterIntakeLabel(_ text: String) {
        mlLevelLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        mlLevelLabel.textColor = .blue
        mlLevelLabel.text = "Left: \(text)"
       
    }
    
    func setUpCircularProgressBar(waterIntake: Int) {
        circularProgressBar = CircularProgressBar(frame: CGRect(x: 0, y: 0, width: 250, height: 250), totalWaterIntake: waterIntake)
        viewForProgressBar.addSubview(circularProgressBar!)
    }
}
