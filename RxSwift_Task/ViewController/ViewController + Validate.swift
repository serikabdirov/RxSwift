//
//  ViewController + Validate.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 24.08.2022.
//

import Foundation

extension ViewController {
    static func validateEmail(_ enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    static func validateFullName(_ enteredFullName: String) -> Bool {
        enteredFullName.split(separator: " ").count >= 2
    }
    
    static func validateDate(_ enteredDate: Date) -> Bool {
        Calendar.current.dateComponents([.day], from: enteredDate, to: .now).day! >= 18 * 365
    }
}
