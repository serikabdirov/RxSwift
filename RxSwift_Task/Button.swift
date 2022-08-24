//
//  Button.swift
//  RxSwift_Task
//
//  Created by Серик Абдиров on 23.08.2022.
//

import UIKit

class Button: UIButton {
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .green : .red
        }
    }
}
