//
//  EmbedProductInTableViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/26.
//

import UIKit

class EmbedProductInTableViewCell: UITableViewCell {
    var showAnotherProduct:((ProductInfo)->Void)?
    
//    var toNewController: UIViewController? = nil
    
    static let identifier: String = "EmbedProductInTableViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
     var configureCellSize: CGSize {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        layout?.estimatedItemSize = .zero
        var cellSize: CGSize = .zero
        cellSize.width = UIScreen.main.bounds.width / 2 - 20
        cellSize.height = 300
        return cellSize
     }
}

extension EmbedProductInTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: -  CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SampleData.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        cell.nameLabel.text = SampleData.products[indexPath.row].name
        cell.priceLabel.text = "$ " +  SampleData.products[indexPath.row].price.description
        cell.pictureImageView.image = nil
        // MARK: -  setImage 未完成

//        if let imgData =  SampleData.products[indexPath.row].media_info {
//            cell.pictureImageView.image = UIImage(data: imgData)
//        }
        // MARK: -  set islikeButton 未完成

//        let isLikeButtonImageName = SampleData.products[indexPath.row].isLike ? "heart.fill" : "heart"
//        cell.isLikeButton.imageView?.image = UIImage(systemName: isLikeButtonImageName)
        
        return cell
        
    }
    
    // MARK: -  CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = SampleData.products[indexPath.row]
        showAnotherProduct?(product)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return configureCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}
