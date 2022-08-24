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
    var fullNameTextField: UITextField!
    var dateTextField: UITextField!

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
            textField.tag = 0
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
            textField.placeholder = "Enter email"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            return textField
        }()
        
        fullNameTextField = {
            let textField = UITextField()
            textField.tag = 1
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
            textField.placeholder = "Enter full name"
            textField.textContentType = .name
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        dateTextField = {
            let textField = UITextField()
            textField.tag = 2
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
            textField.placeholder = "Enter date"
            textField.textContentType = .dateTime
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        nextButton = {
            let button = UIButton()
            button.clipsToBounds = true
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
        stackView.addArrangedSubview(fullNameTextField)
        stackView.addArrangedSubview(dateTextField)
        
        containerView.addSubview(nextButton)

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
            make.height.greaterThanOrEqualTo(110)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
    }

}
