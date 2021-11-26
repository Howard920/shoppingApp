//
//  ProductListCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/25.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    static let identifier: String = "ProductListCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellConfigure()
    }
    
    private func cellConfigure(){
        // 設定cell顏色 圓角
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    

}
