//
//  ProductListCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/25.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    static let identifier: String = "ProductListCell"
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var isLikeButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ cellData: ProductInfo){
        nameLabel.text = cellData.name
        priceLabel.text = "$" + cellData.price.description
//        pictureImageView.image = UIImage(named: "pepsi")
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    

}
