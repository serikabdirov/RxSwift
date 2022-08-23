//
//  View.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 22.08.2022.
//

import UIKit
import SnapKit

class View: UIView {
    
    var scrollView: UIScrollView!
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!

    var nextButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {

        scrollView = {
            let scrollView = UIScrollView()
            scrollView.showsVerticalScrollIndicator = false
            scrollView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
            return scrollView
        }()

        emailTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter email"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            textField.returnKeyType = .next
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter password"
            textField.textContentType = .password
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        nextButton = {
            let button = Button()
            button.isEnabled = false
            button.setTitle("incorrect data", for: .disabled)
            button.setTitleColor(.gray, for: .disabled)
            button.setTitle("Next", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(nextButton)
        
    }
    
    func setConstraints() {        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField).inset(40)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField).inset(40)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(34)
        }
    }

}
