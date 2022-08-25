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
    let disposeBag = DisposeBag()
    
    let datePicker = UIDatePicker()

    override func loadView() {
        myView = View()
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myView.emailTextField.delegate = self
        myView.fullNameTextField.delegate = self
        myView.dateTextField.delegate = self
                
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        myView.nextButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
        createDatePicker()
        rx()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
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
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
        
    }
}
