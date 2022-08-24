//
//  View.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 22.08.2022.
//

import UIKit
import SnapKit

class ContainerView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

class View: UIView {
    
    var scrollView: UIScrollView!
    var containerView: ContainerView!
    
    var stackView: UIStackView!
    
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
            scrollView.contentMode = .center
            scrollView.contentInset = UIEdgeInsets.zero
            scrollView.isScrollEnabled = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        
        containerView = {
            let view = ContainerView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        stackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
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
        
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(nextButton)

    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.height.equalTo(scrollView.frameLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(110)
        }
    }

}
