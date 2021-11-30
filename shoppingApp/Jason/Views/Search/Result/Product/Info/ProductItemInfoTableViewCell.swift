//
//  ProductItemInfoTableViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/22.
//

import UIKit

class ProductItemInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var itemInfoLabel: UILabel!
    
    static let identifier: String = "ProductItemInfoTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
}
