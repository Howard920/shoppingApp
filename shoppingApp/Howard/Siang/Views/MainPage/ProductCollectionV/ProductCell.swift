//
//  ProductCell.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/27.
//

import UIKit

protocol ProductCellDelegate: UIViewController{
    func successfullyAddToCart()
    func productAddToFavorite(item_id: Int)
}


class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var item: ItemCodable!
    weak var delegate: ProductCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setItemCell(item: ItemCodable, image: UIImage?, delegate: ProductCellDelegate?){
        self.item = item
        self.imageView.image = image
        self.delegate = delegate
        
        self.titleLabel.text = item.name
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let price = item.price
        self.priceLabel.text = "NT$ " + formatter.string(from: NSNumber(value: price))!
    }
    
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        
        cartSystem.updateCartProduct(product: OrderProduct(item_count: 1, item: self.item)) {[weak self] error in
            if error == nil{
                self?.delegate?.successfullyAddToCart()
            }else{
                fatalError("加入購物車失敗")
            }
        }
        
    }
    
}
