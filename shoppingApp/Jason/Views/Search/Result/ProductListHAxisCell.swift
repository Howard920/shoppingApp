//
//  ProductListHAxisCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/29.
//

import UIKit

class ProductListHAxisCell: UICollectionViewCell {

    static let identifier: String = "ProductListHAxisCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    

}
