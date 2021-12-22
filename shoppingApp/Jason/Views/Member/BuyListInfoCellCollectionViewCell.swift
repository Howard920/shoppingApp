//
//  BuyListInfoCellCollectionViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/29.
//

import UIKit

class BuyListInfoCellCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "BuyListInfoCellCollectionViewCell"
    var returnEvent:(()->Void)?
    @IBOutlet weak var priceGroupView: UIStackView!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemSpec: UILabel!
    @IBOutlet weak var numberOfItemLabel: UILabel!
    @IBOutlet weak var shipmentStateLabel: UILabel!
    @IBOutlet weak var returnItemButton: UIButton!

    deinit {
        print("BuyListInfoCellCollectionViewCell deinit")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ product: OrderInfo.ProductList, _ shipmentState: String){
        nameLabel.text = product.item.name
        priceLabel.text = product.item.price.description
        itemSpec.text = "無"
        numberOfItemLabel.text = product.item_count.description
        shipmentStateLabel.text = shipmentState
        
        returnItemButton.isEnabled = shipmentState == "已送達" ? true : false
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    @IBAction func returnItemButtonTap(_ sender: UIButton){
        returnEvent?()
    }

}
