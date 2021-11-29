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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }

}
