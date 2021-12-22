//
//  BuyListHeaderCollectionReusableView.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/29.
//

import UIKit

class BuyListHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    static let identifier: String = "BuyListHeaderCollectionReusableView"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
}
