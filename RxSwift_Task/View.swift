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
    
    var emailCorrectLabel: UILabel!
    var passwordCorrectLabel: UILabel!
    
    var stackView: UIStackView!
    
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
        emailTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter email"
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        emailCorrectLabel = {
            let label = UILabel()
            label.text = "Email incorrect"
            label.tintColor = .red
//            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()
        
        passwordCorrectLabel = {
            let label = UILabel()
            label.text = "Password incorrect"
            label.tintColor = .red
//            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()
        
        stackView = {
            let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()
        
        nextButton = {
            let button = UIButton()
            button.isEnabled = false
            button.setTitle("incorrect data", for: .disabled)
            button.setTitleColor(.gray, for: .disabled)
            button.setTitle("Next", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
        }()
        
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(nextButton)
        
    }
    
    func setConstraints() {
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide)
//            make.leading.equalTo(12)
//            make.trailing.equalTo(-12)
//        }
        
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
            make.bottom.equalTo(safeAreaLayoutGuide).priority(.low)
        }
    }

}
