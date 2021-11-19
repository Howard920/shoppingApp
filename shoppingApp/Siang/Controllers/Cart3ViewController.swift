//
//  Cart3ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

import UIKit

class Cart3ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cartStepView: CartStepView!
    @IBOutlet var stackViews: [UIStackView]!
    @IBOutlet var rows: [UIView]!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartStepView.stepLabels[2].textColor = UIColor.red
        cartStepView.stepBars[2].backgroundColor = UIColor.red
        stackViews[0].layer.borderWidth = 0.5
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.cornerRadius = 5
        emailTextField.clipsToBounds = true
        stackViews[0].layer.borderColor = UIColor.lightGray.cgColor
        stackViews[0].layer.cornerRadius = 5
        stackViews[0].clipsToBounds = true
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: rows[0].frame.height - 0.5, width: rows[0].frame.width, height: 0.5)
        bottomLine1.backgroundColor = UIColor.lightGray.cgColor
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: rows[0].frame.height - 0.5, width: rows[0].frame.width, height: 0.5)
        bottomLine2.backgroundColor = UIColor.lightGray.cgColor
        rows[0].layer.addSublayer(bottomLine1)
        rows[1].layer.addSublayer(bottomLine2)
        sendButton.layer.cornerRadius = 5
        sendButton.clipsToBounds = true
        
    }
    
    
}

 
