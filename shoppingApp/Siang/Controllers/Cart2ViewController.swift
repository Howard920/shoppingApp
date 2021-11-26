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
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultValue()
        setLayout()
        setRelationship()
    }
    
    func setDefaultValue(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        totalPriceLabel.text = "NT $" + formatter.string(from: NSNumber(value: orderSiang.price.value))!
    }
    
    func setLayout(){
        cartStepView.stepLabels[1].textColor = UIColor.red
        cartStepView.stepBars[1].backgroundColor = UIColor.red
        nextStepButton.layer.cornerRadius = 5
        nextStepButton.clipsToBounds = true
    }
    
    func setRelationship(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "Cart2TableViewCell", bundle: nil), forCellReuseIdentifier: "Cart2TableViewCell")
    }
    
    
    
    @IBAction func nextStepPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStep3", sender: nil)
        print(orderSiang)
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
        if section == 0{
            return Payment.allCases.count
        }else{
            return Shipment.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart2TableViewCell") as! Cart2TableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        if indexPath.section == 0{
            cell.lb_title.text = Payment.allCases[indexPath.row].rawValue
            if Payment.allCases[indexPath.row] == orderSiang.payment{
                cell.is_btn_selected = true
            }else{
                cell.is_btn_selected = false
            }
        }else{
            cell.lb_title.text = Shipment.allCases[indexPath.row].rawValue
            if Shipment.allCases[indexPath.row] == orderSiang.ship{
                cell.is_btn_selected = true
            }else{
                cell.is_btn_selected = false
            }
        }
        
        return cell
    }
    
    
    
}

extension Cart2ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cell_btn_select(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension Cart2ViewController: Cart2TableViewCellDelegate{
    func cell_btn_select(at indexPath: IndexPath) {
        if indexPath.section == 0{
            orderSiang.payment = Payment.allCases[indexPath.row]
        }else{
            orderSiang.ship = Shipment.allCases[indexPath.row]
        }
        tableView.reloadData()
    }
    
    
}
