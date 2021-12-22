//
//  ProductCell.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/27.
//

import UIKit

protocol ProductCellDelegate: UIViewController{
    func successfullyAddToCart()
    func productAddToFavorite()
    func productDeleteFromFavorite()
}


class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoiteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    var item: ItemCodable!
    weak var delegate: ProductCellDelegate?
    var isFavorite: Bool{
        UserInfo.favoriteList.contains(item.item_id)
    }
    

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
        cartButton.imageView?.tintColor = .black
        if isFavorite{
            favoiteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoiteButton.imageView?.tintColor = .systemPink
        }else{
            favoiteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoiteButton.imageView?.tintColor = .black
        }
    }
    
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        
        cartSystem.updateCartProduct(product: OrderProduct(add_time: Date.get_add_time(), item_count: 1, item: self.item)) {[weak self] error in
            if error == nil{
                self?.delegate?.successfullyAddToCart()
            }else{
                fatalError("加入購物車失敗")
            }
        }
        
    }
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let item_id = item.item_id
        if isFavorite{
            let index = favoriteSystem.favoriteList.firstIndex(of: item_id)!
            favoriteSystem.favoriteList.remove(at: index)
            favoiteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoiteButton.imageView?.tintColor = .black
            delegate?.productDeleteFromFavorite()
        }else{
            favoriteSystem.favoriteList.append(item_id)
            favoiteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoiteButton.imageView?.tintColor = .systemPink
            delegate?.productAddToFavorite()
        }
    }
    
}
