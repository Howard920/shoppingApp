//
//  AlertViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/14.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 15
        alertView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
