//
//  View.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 22.08.2022.
//

import UIKit
import SnapKit

class View: UIView {
    private var containerView: UIView!
    private var stackView: UIStackView!
    
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
    
    private func setupViews() {
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.showsVerticalScrollIndicator = false
            scrollView.keyboardDismissMode = .onDrag
            scrollView.alwaysBounceVertical = true
            scrollView.contentInsetAdjustmentBehavior = .never
            return scrollView
        }()
        
        containerView = {
            let view = UIView()
            return view
        }()
        
        stackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            return stackView
        }()

        emailTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter email"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            textField.returnKeyType = .next
            return textField
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter password"
            textField.textContentType = .password
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        nextButton = {
            let button = UIButton()
            button.isEnabled = false
            button.setTitle("incorrect data", for: .disabled)
            button.setTitleColor(.gray, for: .disabled)
            button.setBackgroundColor(.red, for: .disabled)
            button.setTitle("Next", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.setBackgroundColor(.green, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            return button
        }()
        
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(nextButton)

    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(scrollView.frameLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(110)
        }
    }

}
