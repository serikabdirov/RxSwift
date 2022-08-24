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
    
    var myView: View!
    
    var disposeBag = DisposeBag()

    var isPasswordCorrect: Bool = false
    var isEmailCorrect: Bool = false

    var passwordTextFieldEvent: ControlEvent<()>!
    var emailTextFieldEvent: ControlEvent<()>!

    override func loadView() {
        myView = View()
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myView.emailTextField.delegate = self
        myView.passwordTextField.delegate = self
        
        navigationController?.hidesBarsWhenKeyboardAppears = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        passwordTextFieldEvent = myView.passwordTextField.rx.controlEvent(.editingChanged)
        emailTextFieldEvent = myView.emailTextField.rx.controlEvent(.editingChanged)

        myView.nextButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
        rx()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func rx() {
        passwordTextFieldEvent.subscribe({ [unowned self] _ in
            isPasswordCorrect = validatePassword(self.myView.passwordTextField.text ?? "")
            self.myView.nextButton.isEnabled = isPasswordCorrect && isEmailCorrect
        }).disposed(by: disposeBag)

        emailTextFieldEvent.subscribe({ [unowned self] _ in
            isEmailCorrect = validateEmail(self.myView.emailTextField.text ?? "")
            self.myView.nextButton.isEnabled = isPasswordCorrect && isEmailCorrect
        }).disposed(by: disposeBag)
    }

    func validateEmail(_ enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }

    func validatePassword(_ enteredPassword: String) -> Bool {
        return enteredPassword.count >= 8
    }

    @objc func nextViewController() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = myView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 100
        myView.scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
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
