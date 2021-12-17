//
//  CartViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit
var orderSiang: OrderSiang!
class Cart1ViewController: UIViewController {

    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartStepView: CartStepView!
    @IBOutlet weak var nextStepButton: UIButton!
    var totalPrice: Int = 0{
        didSet{
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            totalPriceLabel?.text = "NT$ " + formatter.string(from: NSNumber(value: totalPrice))!
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setRelationship()
        cartSystem.getCart { [unowned self] in
            DispatchQueue.main.async {
                loadingView.isHidden = true
                totalPrice = cartSystem.cart.price
            }
        }
    }
    
    private func setLayout(){
        cartStepView.stepBars[0].backgroundColor = UIColor.red
        cartStepView.stepLabels[0].textColor = UIColor.red
        nextStepButton.layer.cornerRadius = 5
        nextStepButton.clipsToBounds = true
    }
    
    private func setRelationship(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Cart1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cart1TableViewCell")
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
        return cartSystem.cart.product_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart1TableViewCell") as! Cart1TableViewCell
        cell.setItem(orderProduct: cartSystem.cart.product_list[indexPath.row],
                     image: cartSystem.productImages[indexPath.row],
                     row: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    
}
extension Cart1ViewController: Cart1TableViewCellDelegate{
    
    func deleteItem(at row: Int) {
        let alertSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertSheetController.addAction(UIAlertAction(title: "刪除商品", style: .destructive, handler: { [unowned self] action in
            var productChanged = cartSystem.cart.product_list[row]
            productChanged.item_count = 0
            cartSystem.updateCartProduct(product: productChanged) { [unowned self] error in
                if error == nil{
                    DispatchQueue.main.async {
                        tableView.reloadData()
                        totalPrice = cartSystem.cart.price
                    }
                }
            }
        }))
        alertSheetController.addAction(UIAlertAction(title: "移入收藏", style: .default, handler: nil))
        alertSheetController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alertSheetController, animated: true, completion: nil)
        
    }
    
    func increaseItemCount(at row: Int) {
        var productChanged = cartSystem.cart.product_list[row]
        productChanged.item_count += 1
        cartSystem.updateCartProduct(product: productChanged) { [unowned self] error in
            if error == nil{
                DispatchQueue.main.async {
                    tableView.reloadData()
                    totalPrice = cartSystem.cart.price
                }
            }else{
                fatalError()
            }
        }
    }
    
    func decreaseItemCount(at row: Int) {
        var productChanged = cartSystem.cart.product_list[row]
        productChanged.item_count -= 1
        cartSystem.updateCartProduct(product: productChanged) { [unowned self] error in
            if error == nil{
                DispatchQueue.main.async {
                    tableView.reloadData()
                    totalPrice = cartSystem.cart.price
                }
            }else{
                fatalError()
            }
        }
    }
}
