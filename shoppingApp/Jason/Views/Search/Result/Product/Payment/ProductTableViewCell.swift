//
//  ProductTableViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/19.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentLogoImageView: UIImageView!
    
    static let identifier: String = "ProductTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
