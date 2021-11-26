//
//  PaymentTableViewCell.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

protocol Cart1TableViewCellDelegate: AnyObject{
    func deleteItem(at indexPath: IndexPath)
    func increaseItemNum(at indexPath: IndexPath)
    func decreaseItemNum(at indexPath: IndexPath)
}
class Cart1TableViewCell: UITableViewCell {

    
    @IBOutlet weak var price_lb: UILabel!
    @IBOutlet weak var title_lb: UILabel!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var num_lb: UILabel!
    var num: Int = 1{
        didSet{
            num_lb.text = String(num)
        }
    }
    var indexPath: IndexPath!
    weak var delegate: Cart1TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItem(orderItem: OrderItem){
        title_lb.text = orderItem.product.name
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        price_lb.text = "NT $" + numberFormatter.string(from: NSNumber(value: orderItem.product.price))!
        num_lb.text = String(orderItem.num)
        image_view.image = orderItem.product.image
    }

    @IBAction func add_btn_pressed(_ sender: UIButton) {
        delegate?.increaseItemNum(at: indexPath)
    }
    
    @IBAction func cancel_btn_pressed(_ sender: UIButton) {
        delegate?.deleteItem(at: indexPath)
    }
    @IBAction func minus_btn_pressed(_ sender: Any) {
        delegate?.decreaseItemNum(at: indexPath)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
