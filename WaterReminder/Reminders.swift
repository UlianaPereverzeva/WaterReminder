//
//  Reminders.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

final class Reminders: UIViewController {
    
    private var tableView: UITableView!
    //var selectedTime: TimeInterval?
    
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
extension Reminders: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
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
                    return cell
                case .second:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReminderCell
            cell.configure(text: "hello", time: "00:30")
                    return cell
                case .none:
                    fatalError("Invalid section")
                }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTimePicker()
    }
    
    func showTimePicker() {
        
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)

            let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
            datePicker.locale = Locale(identifier: "ru_RU") // Установите локаль, если вы хотите отображать время в другой локали
            datePicker.frame = CGRect(x: 0, y: 0, width: alertController.view.frame.width - 20, height: 160)

            alertController.view.addSubview(datePicker)

            let doneAction = UIAlertAction(title: "Готово", style: .default) { _ in
                let selectedTime = datePicker.countDownDuration
                self.handleSelectedTime(selectedTime)
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

            alertController.addAction(doneAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }

        func handleSelectedTime(_ timeInSeconds: TimeInterval) {
            //selectedTime = timeInSeconds
            let hours = Int(timeInSeconds) / 3600
            let minutes = (Int(timeInSeconds) % 3600) / 60

            let formattedString = String(format: "%02dч %02dмин", hours, minutes)
            print("Selected Time: \(formattedString)")
            tableView.reloadData()
        }
}
