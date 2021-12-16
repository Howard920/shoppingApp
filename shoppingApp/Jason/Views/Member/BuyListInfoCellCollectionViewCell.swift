//
//  BuyListInfoCellCollectionViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/29.
//

import UIKit

class BuyListInfoCellCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "BuyListInfoCellCollectionViewCell"
    
    @IBOutlet weak var priceGroupView: UIStackView!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemSpec: UILabel!
    @IBOutlet weak var numberOfItemLabel: UILabel!
    @IBOutlet weak var shipmentStateLabel: UILabel!
    @IBOutlet weak var returnItem: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }

}
