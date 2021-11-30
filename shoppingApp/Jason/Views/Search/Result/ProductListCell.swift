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
        cellConfigure()
    }
    
    private func cellConfigure(){
        // 設定cell顏色 圓角
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    

}



//ResultCollectionViewCell
//import UIKit
//protocol ResultCollectionViewCellDelegate: AnyObject {
//    func didTapButton(cell: ResultCollectionViewCell)
//}
//class ResultCollectionViewCell: UICollectionViewCell {
//    weak var delegate: ResultCollectionViewCellDelegate?
//    static let identifier: String = "ResultCollectionViewCell"
//
//    @IBOutlet weak var resultImageView: UIImageView!
//    @IBOutlet weak var resultNameLabel: UILabel!
//    @IBOutlet weak var resultPriceLabel: UILabel!
//    @IBOutlet weak var isLikeButton: UIButton!
//    
//    func configure(_ indexPath: IndexPath){
//        resultNameLabel.text = Products.demoRoom[indexPath.row].name
//        resultPriceLabel.text = "$ " + Products.demoRoom[indexPath.row].price.description
//        resultImageView.image = UIImage(data: Products.demoRoom[indexPath.row].picture!)
//        if Products.demoRoom[indexPath.row].isLike {
//            isLikeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
//        } else {
//            isLikeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
//        }
//    }
//   
//    @IBAction func didTapLikeButton(_ sender: UIButton) {
//        delegate?.didTapButton(cell: self)
//        
//    }
//}
