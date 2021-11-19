//
//  PaymentViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

class Cart2ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartStepView: CartStepView!
    @IBOutlet weak var nextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        cartStepView.stepLabels[1].textColor = UIColor.red
        cartStepView.stepBars[1].backgroundColor = UIColor.red
        tableView.register(UINib(nibName: "Cart2TableViewCell", bundle: nil), forCellReuseIdentifier: "Cart2TableViewCell")
        nextStepButton.layer.cornerRadius = 5
        nextStepButton.clipsToBounds = true
        
        
    }
    
    @IBAction func nextStepPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStep3", sender: nil)
    }
    
}

extension Cart2ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        
        headerText.font = UIFont.systemFont(ofSize: 14)
        switch section{
        case 0:
            headerText.textAlignment = .left
            headerText.text = "付款方式"
        default:
            headerText.textAlignment = .left
            headerText.text = "運送方式"
        }
        
        return headerText
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart2TableViewCell")!
        
        return cell
    }
    
    
}

extension Cart2ViewController: UITableViewDelegate{
    
}
