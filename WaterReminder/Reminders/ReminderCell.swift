//
//  ReminderCell.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class ReminderCell: UITableViewCell {
    
    private var text = UILabel()
    private var time = UILabel()
    private var arrow = UIImageView()
    
    func configure(text: String, time: String) {
        self.text.text = text
        self.time.text = time
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUi() {
        
        self.text.translatesAutoresizingMaskIntoConstraints = false
        self.time.translatesAutoresizingMaskIntoConstraints = false
        self.arrow.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(text)
        self.contentView.addSubview(time)
        self.contentView.addSubview(arrow)
        
        let arrowImage = UIImage(named: "arrow")
        self.arrow.image = arrowImage
        self.arrow.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            self.text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.text.widthAnchor.constraint(equalToConstant: 90),
            
            self.time.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.time.leadingAnchor.constraint(equalTo: text.trailingAnchor, constant: 100),
            
            self.arrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.arrow.leadingAnchor.constraint(equalTo: time.trailingAnchor, constant: 10),
            self.arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            self.arrow.widthAnchor.constraint(equalToConstant: 19),
            self.arrow.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        self.text.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.text.textAlignment = .left
        
        self.time.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.time.textAlignment = .right
    }
    
    func updateCellStyle(isEnabled: Bool) {
        text.textColor = isEnabled ? .white : UIColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00)
        time.textColor = isEnabled ? .white : UIColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00)
        //arrow.tintColor = isEnabled ? .darkGray : .lightGray
        selectionStyle = isEnabled ? .default : .none
        isUserInteractionEnabled = isEnabled
    }
}

final class SwitchTableViewCell: UITableViewCell {
    
    private var text = UILabel()
    var switchControl = UISwitch()
    weak var delegate: SwitchTableViewCellDelegate?
    
    func configure(text: String) {
        self.text.text = text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUi() {
        
        self.selectionStyle = .none
        
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
        self.text.textColor = .white
        self.text.textAlignment = .left
        
        switchControl.isOn = false
        switchControl.layer.cornerRadius = switchControl.frame.height / 2.0
        switchControl.backgroundColor = UIColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00)
        switchControl.clipsToBounds = true
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchCellValueChanged(sender.isOn)
        if sender.isOn {
            self.text.textColor = UIColor.white
        } else {
            self.text.textColor = UIColor(red: 0.56, green: 0.71, blue: 1.00, alpha: 1.00)
            //self.selectionStyle = .none
        }
    }
}
protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCellValueChanged(_ isOn: Bool)
}
    
    

