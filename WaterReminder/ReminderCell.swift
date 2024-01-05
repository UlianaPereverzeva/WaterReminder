//
//  ReminderCell.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class ReminderCell: UITableViewCell {
    
    private let text = UILabel()
    private let time = UILabel()
    private var arrow = UIImageView()

    func configure(text: String, time: String) {
        setUpUi()
        self.text.text = text
        self.time.text = time
    }
    
    func setUpUi() {
        
        self.text.translatesAutoresizingMaskIntoConstraints = false
        self.time.translatesAutoresizingMaskIntoConstraints = false
        self.arrow.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(text)
        self.contentView.addSubview(time)
        self.contentView.addSubview(arrow)
        
        let arrowImage = UIImage(named: "arrow")
        arrow.image = arrowImage

        NSLayoutConstraint.activate([
            self.text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            //self.text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            self.text.widthAnchor.constraint(equalToConstant: 90),
            
            self.time.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.time.leadingAnchor.constraint(equalTo: text.trailingAnchor, constant: 100),
            self.text.widthAnchor.constraint(equalToConstant: 50),

            //self.time.heightAnchor.constraint(equalToConstant: 24),
            
            self.arrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.arrow.leadingAnchor.constraint(equalTo: time.trailingAnchor, constant: 10),
            self.arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            self.arrow.widthAnchor.constraint(equalToConstant: 19),
            self.arrow.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        self.text.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.text.textColor = .darkGray
        self.text.textAlignment = .left
        
        self.time.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.time.textColor = .darkGray
        self.time.textAlignment = .right
        
        self.arrow.contentMode = .scaleAspectFit

    }

}

final class SwitchTableViewCell: UITableViewCell {
    
    private let text = UILabel()
    var switchControl = UISwitch()
    
    func configure(text: String) {
        setUpUi()
        self.text.text = text
    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
    func setUpUi() {
        
        contentView.addSubview(switchControl)
        contentView.addSubview(text)
        
        self.switchControl.translatesAutoresizingMaskIntoConstraints = false
        self.text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.text.widthAnchor.constraint(equalToConstant: 90),
            
            switchControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        self.text.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.text.textColor = .darkGray
        self.text.textAlignment = .left
        
        switchControl.isOn = false
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        // Ваш код обработки изменения состояния
    }
}

    
    

