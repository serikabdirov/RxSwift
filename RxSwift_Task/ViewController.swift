//
//  ViewController.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 22.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private var myView: View!
    
    private let disposeBag = DisposeBag()

    override func loadView() {
        myView = View()
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myView.emailTextField.delegate = self
        myView.passwordTextField.delegate = self
                
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        myView.nextButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
        rx()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    private static func validateEmail(_ enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    private static func validatePassword(_ enteredPassword: String) -> Bool {
        enteredPassword.count >= 8
    }

    private func rx() {
        
        let emailValidate = myView.emailTextField.rx.text.orEmpty.map {
            Self.validateEmail($0)
        }
        
        let passwordValidate = myView.passwordTextField.rx.text.orEmpty.map {
            Self.validatePassword($0)
        }
        
        Observable.combineLatest(emailValidate, passwordValidate)
            .map { $0 && $1 }
            .bind(to: myView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    @objc private func nextViewController() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = myView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 100
        myView.scrollView.contentInset = contentInset
    }

    @objc private func keyboardWillHide(notification:NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        myView.scrollView.contentInset = contentInset
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        if textField == myView.emailTextField {
            myView.passwordTextField.becomeFirstResponder()
        }
        return true
        
    }
}
