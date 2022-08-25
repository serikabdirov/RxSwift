//
//  ViewCOntroller + DatePicker.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 24.08.2022.
//

import UIKit

extension ViewController {
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        myView.dateTextField.inputView = datePicker
        myView.dateTextField.inputAccessoryView = createToolbar()
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    static func formatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "ru_ru")
        return formatter.string(from: date)
    }
}
