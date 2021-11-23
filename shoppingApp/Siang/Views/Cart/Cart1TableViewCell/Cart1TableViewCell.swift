//
//  PaymentTableViewCell.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

protocol Cart1TableViewCellDelegate: AnyObject{
    
}
class Cart1TableViewCell: UITableViewCell {

    
    @IBOutlet weak var price_lb: UILabel!
    @IBOutlet weak var title_lb: UILabel!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var num_lb: UILabel!
    var indexPath: IndexPath!
    weak var delegate: Cart1TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func add_btn_pressed(_ sender: UIButton) {
    }
    
    @IBAction func minus_btn_pressed(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
