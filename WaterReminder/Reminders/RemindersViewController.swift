//
//  Reminders.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

enum ReminderSettingsType {
    case from
    case to
    case interval
}

final class RemindersViewController: UIViewController {
    
    private var presenter: RemindersPresenterProtocol = RemindersPresenter()

    private var tableView: UITableView!
    let intervals = ["15 минут", "30 минут", "1 час", "2 часа"]
    var configuration = Configuration(reminders: false, from: "00:00", to: "00:00", interval: "0")
    
    private enum Section: Int {
        case first
        case second
        
        static var count: Int {
            return 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.presenter.setView(self)
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(ReminderCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "switchCell")
        
        self.tableView = tableView
    }
}
extension RemindersViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            1
        } else {
            3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Section(rawValue: indexPath.section) {
        case .first:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchTableViewCell
            cell.configure(text: "Reminders")
            cell.switchControl.isOn = configuration.reminders
            cell.delegate = self
            return cell
        case .second:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReminderCell
            switch indexPath.row {
            case 0:
                cell.configure(text: "From", time: configuration.from)
            case 1:
                cell.configure(text: "To", time: configuration.to)
            case 2:
                cell.configure(text: "Interval", time: configuration.interval)
            default:
                cell.configure(text: "", time: "")
            }
            cell.updateCellStyle(isEnabled: configuration.reminders)
            return cell
        case .none:
            fatalError("Invalid section")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section != 0 {

            let type: ReminderSettingsType
            switch indexPath.row {
            case 0:
                type = .from
            case 1:
                type = .to
            case 2:
                type = .interval
            default:
                return
            }
            presenter.didSelectSettingsType(type: type)
        }
    }
}

extension RemindersViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        intervals.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        intervals[row]
     }

     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        configuration.interval = intervals[row]
     }
}

extension RemindersViewController: RemindersViewProtocol {
    
    func updateLabelInCell(value: Configuration) {
        self.configuration = value
    }
    
    func showTimePicker() {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.frame = CGRect(x: 0, y: 0, width: alertController.view.frame.width - 20, height: 160)
        
        alertController.view.addSubview(datePicker)
        

        let doneAction = UIAlertAction(title: "Save", style: .default) { _ in
            let selectedTime = datePicker.countDownDuration
            
            self.presenter.handleSelectedTime(selectedTime)
            self.tableView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

    func showIntervalPicker() {
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let IntervalPicker = UIPickerView()
        IntervalPicker.delegate = self
        IntervalPicker.dataSource = self
        IntervalPicker.frame = CGRect(x: 0, y: 0, width: alertController.view.frame.width - 20, height: 160)
        alertController.view.addSubview(IntervalPicker)
        
        let doneAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.presenter.handleSelectedInterval(self.configuration.interval)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
extension RemindersViewController: SwitchTableViewCellDelegate {
    func switchCellValueChanged(_ isOn: Bool) {
        configuration.reminders = isOn
        print(configuration.reminders)
        tableView.reloadData()
    }
}

