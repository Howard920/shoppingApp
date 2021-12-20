//
//  AlertViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/14.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var alertTextLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    var alertText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 15
        alertView.clipsToBounds = true
        if alertText != nil{
            alertTextLabel.text = alertText!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
