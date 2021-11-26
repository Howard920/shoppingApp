//
//  CartViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

var orderSiang = OrderSiang()

class Cart1ViewController: UIViewController {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartStepView: CartStepView!
    
    @IBOutlet weak var nextStepButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setRelationship()
        setData()
    
        orderSiang.price.valueChanged = { [unowned self] price in
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            self.totalPriceLabel.text = "NT$ " + formatter.string(from: NSNumber(value: price))!
        }
        
    }
    
    func setLayout(){
        cartStepView.stepBars[0].backgroundColor = UIColor.red
        cartStepView.stepLabels[0].textColor = UIColor.red
        nextStepButton.layer.cornerRadius = 5
        nextStepButton.clipsToBounds = true
    }
    
    func setRelationship(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Cart1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cart1TableViewCell")
    }
    ///暫時設定

    func setData(){
        orderSiang.orderItems = [
            OrderItem(product: ProductSamples.productSample1),
            OrderItem(product: ProductSamples.productSample2),
            OrderItem(product: ProductSamples.productSample3)
        ]
        
    }
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextStepPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStep2", sender: nil)
    }
}

extension Cart1ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderSiang.orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart1TableViewCell") as! Cart1TableViewCell
        cell.setItem(orderItem: orderSiang.orderItems[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    
}
extension Cart1ViewController: Cart1TableViewCellDelegate{
    
    func increaseItemNum(at indexPath: IndexPath) {
        orderSiang.orderItems[indexPath.row].num += 1
        let cell = tableView.cellForRow(at: indexPath) as! Cart1TableViewCell
        cell.num = orderSiang.orderItems[indexPath.row].num
    }
    
    func decreaseItemNum(at indexPath: IndexPath) {
        if orderSiang.orderItems[indexPath.row].num == 1{
            deleteItem(at: indexPath)
            return
        }else{
            orderSiang.orderItems[indexPath.row].num -= 1
            let cell = tableView.cellForRow(at: indexPath) as! Cart1TableViewCell
            cell.num = orderSiang.orderItems[indexPath.row].num
        }
    }
    
    func deleteItem(at indexPath: IndexPath) {
        let alertSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertSheetController.addAction(UIAlertAction(title: "刪除商品", style: .destructive, handler: { [unowned self] action in
            orderSiang.orderItems.remove(at: indexPath.row)
            self.tableView.reloadData()
        }))
        alertSheetController.addAction(UIAlertAction(title: "移入收藏", style: .default, handler: nil))
        alertSheetController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alertSheetController, animated: true, completion: nil)
        
    }
    
}
extension Cart1ViewController: UITableViewDelegate{
    
}
