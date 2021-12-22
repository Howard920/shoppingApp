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
    
    var favoriteItemToChange:((_ message: String)->Void)?
    var product:ProductInfo?{
        didSet{
            guard let itemID = product?.item_id else {
                return
            }
            if UserInfo.favoriteList.contains(itemID){
                isLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else {
                isLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
//            if UserInfo.cartList.contains(itemID){
//                cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
//            } else {
//                cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ cellData: ProductInfo){
        nameLabel.text = cellData.name
        priceLabel.text = "$" + cellData.price.description
        pictureImageView.image = nil
        product = cellData
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    @IBAction func favoriteButtonDidTap(_ sender: UIButton){
        guard let product = product else {
            return
        }
        var msg = ""

        if UserInfo.favoriteList.contains(product.item_id){
            if let index = UserInfo.favoriteList.firstIndex(of: product.item_id){
                UserInfo.favoriteList.remove(at: index)
                msg = Common.unfavorite
            }
        } else {
            UserInfo.favoriteList.append(product.item_id)
            msg = Common.favorite

        }
        favoriteItemToChange?(msg)
    }
    
    @IBAction func cartButtonDidTap(_ sender: UIButton){
        guard let product = product else {
            return
        }
        var msg = ""

        if UserInfo.cartList.contains(product.item_id){
//            if let index = UserInfo.cartList.firstIndex(of: product.item_id){
//                UserInfo.cartList.remove(at: index)
//
//            }
            msg = Common.cart
        } else {
            UserInfo.cartList.append(product.item_id)
            Common.addItemToCart(product)
            msg = Common.cart

        }
        favoriteItemToChange?(msg)
        
    }
    
    
}
