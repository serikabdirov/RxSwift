//
//  ViewController + Rx.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 24.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

extension ViewController {
    func rx() {
        let emailValidate = myView.emailTextField.rx.text.orEmpty.map {
            Self.validateEmail($0)
        }
        
        let fullNameValidate = myView.fullNameTextField.rx.text.orEmpty.map {
            Self.validateFullName($0)
        }
        
        let dateValidate = datePicker.rx.date.map {
            Self.validateDate($0)
        }
        
        let toggleValidate = myView.toggle.rx.value
        
        let dateChange = datePicker.rx.date.map {
            Self.formatter($0)
        }
        
        Observable.combineLatest(emailValidate, fullNameValidate, dateValidate, toggleValidate)
            .map { $0 && $1 && $2 && $3}
            .bind(to: myView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        dateChange.bind(to: myView.dateTextField.rx.text)
            .disposed(by: disposeBag)
        
        emailValidate.subscribe { [unowned self] event in
            if self.myView.emailTextField.isEditing {
                self.myView.emailTextField.layer.borderColor = event.element! ? CGColor.init(red: 0, green: 1, blue: 0, alpha: 1) : CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
            }
        }.disposed(by: disposeBag)
        
        fullNameValidate.subscribe { [unowned self] event in
            if self.myView.fullNameTextField.isEditing {
                self.myView.fullNameTextField.layer.borderColor = event.element! ? CGColor.init(red: 0, green: 1, blue: 0, alpha: 1) : CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
            }
        }.disposed(by: disposeBag)
        
        dateValidate.subscribe { [unowned self] event in
            if self.myView.dateTextField.isEditing {
                self.myView.dateTextField.layer.borderColor = event.element! ? CGColor.init(red: 0, green: 1, blue: 0, alpha: 1) : CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
            }
        }.disposed(by: disposeBag)
    }
}
