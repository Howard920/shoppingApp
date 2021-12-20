//
//  PaymentTableViewCell.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

protocol Cart1TableViewCellDelegate: AnyObject{
    func deleteItem(at row: Int)
    func increaseItemCount(at row: Int)
    func decreaseItemCount(at row: Int)
}

class Cart1TableViewCell: UITableViewCell {

    @IBOutlet weak var price_lb: UILabel!
    @IBOutlet weak var title_lb: UILabel!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var num_lb: UILabel!
        
    var row: Int!
    weak var delegate: Cart1TableViewCellDelegate?
    
    func setItem(orderProduct: OrderProduct, image: UIImage?, row: Int){
        title_lb.text = orderProduct.item.name
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        price_lb.text = "NT $" + numberFormatter.string(from: NSNumber(value: orderProduct.item.price))!
        
        num_lb.text = String(orderProduct.item_count)
        
        image_view.image = image
        self.row = row
    }
    
    @IBAction func add_btn_pressed(_ sender: UIButton) {
        delegate?.increaseItemCount(at: row)
    }
    
    @IBAction func cancel_btn_pressed(_ sender: UIButton) {
        delegate?.deleteItem(at: row)
    }
    
    @IBAction func minus_btn_pressed(_ sender: Any) {
        if Int(num_lb.text!) == 1{
            delegate?.deleteItem(at: row)
        }else{
            delegate?.decreaseItemCount(at: row)
        }
    }
    
}
