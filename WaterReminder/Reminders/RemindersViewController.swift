//
//  Reminders.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class RemindersViewController: UIViewController {
    
    private var presenter: RemindersPresenterProtocol = RemindersPresenter()
    var saveButton: UIButton?

    private var tableView: UITableView!
    let intervals = ["1", "2", "3"]
    let hoursArray: [String] = {
            var hours = [String]()
            for hour in 0..<24 {
                hours.append(String(format: "%02d", hour))
            }
            return hours
        }()
    var isIntervalSelection = false
    var configuration: Configuration?
    
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
        self.presenter.viewDidLoad()
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(ReminderCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "switchCell")
        tableView.backgroundColor = .systemBlue
        tableView.tintColor = .systemBlue
        
        self.tableView = tableView
    }
}
extension RemindersViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.switchControl.isOn = configuration?.reminders ?? false
            cell.delegate = self
            cell.backgroundColor = .systemBlue
            return cell
        case .second:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReminderCell
            switch indexPath.row {
            case 0:
                cell.configure(text: "From", time: String(configuration?.from ?? 0) + ":00")
            case 1:
                cell.configure(text: "To", time: String(configuration?.to ?? 0) + ":00")
            case 2:
                cell.configure(text: "Interval", time: String(configuration?.interval ?? 0) + " hour")
            default:
                cell.configure(text: "", time: "")
            }
            cell.updateCellStyle(isEnabled: configuration?.reminders ?? false)
            cell.backgroundColor = .systemBlue
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
        if isIntervalSelection {
            return intervals.count
        } else {
            return hoursArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isIntervalSelection {
            return intervals[row]
        } else {
            return hoursArray[row] + ":00"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        configuration.interval = intervals[row]
    }
}

extension RemindersViewController: RemindersViewProtocol {
    
    func refresh(with configuration: Configuration) {
        self.configuration = configuration
        self.tableView.reloadData()
    }
    
    func showTimePicker() {
        isIntervalSelection = false

        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIPickerView()
        datePicker.delegate = self
        datePicker.dataSource = self
        datePicker.frame = CGRect(x: 0, y: 0, width: alertController.view.frame.width - 20, height: 160)
        alertController.view.addSubview(datePicker)
        
        let doneAction = UIAlertAction(title: "Save", style: .default) { _ in
            let selectedTimeRow = datePicker.selectedRow(inComponent: 0)
            let selectedTime = self.hoursArray[selectedTimeRow]
            self.presenter.handleSelectedTime(selectedTime)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func showIntervalPicker() {
        isIntervalSelection = true

        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let intervalPicker = UIPickerView()
        intervalPicker.delegate = self
        intervalPicker.dataSource = self
        intervalPicker.frame = CGRect(x: 0, y: 0, width: alertController.view.frame.width - 20, height: 160)
        alertController.view.addSubview(intervalPicker)
        
        let doneAction = UIAlertAction(title: "Save", style: .default) { _ in
            let selectedIntervalRow = intervalPicker.selectedRow(inComponent: 0)
            let selectedInterval = self.intervals[selectedIntervalRow]
            self.presenter.handleSelectedTime(selectedInterval)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
extension RemindersViewController: SwitchTableViewCellDelegate {
    func switchCellValueChanged(_ isOn: Bool) {
        self.presenter.handleSwitchValueChanged(isOn: isOn)
    }
}

