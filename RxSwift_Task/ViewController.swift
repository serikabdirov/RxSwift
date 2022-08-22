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
    
    override func loadView() {
        myView = View()
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.passwordTextField.rx.controlEvent(.editingChanged).asObservable().subscribe({ [unowned self] _ in
            if self.myView.passwordTextField.text?.count ?? 0 >= 8 {
                self.myView.nextButton.isEnabled = true
            }
        }).disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }


}

