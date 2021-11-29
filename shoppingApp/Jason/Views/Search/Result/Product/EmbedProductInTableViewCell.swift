//
//  EmbedProductInTableViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/26.
//

import UIKit

class EmbedProductInTableViewCell: UITableViewCell {
    
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
//        cellSize.height = (UIScreen.main.bounds.width - 30) / 2 + 125
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
        
        return Products.demoRoom.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        cell.nameLabel.text = Products.demoRoom[indexPath.row].name
        cell.priceLabel.text = "$ " +  Products.demoRoom[indexPath.row].price.description
        if let imgData =  Products.demoRoom[indexPath.row].picture {
            cell.pictureImageView.image = UIImage(data: imgData)
        }
        let isLikeButtonImageName = Products.demoRoom[indexPath.row].isLike ? "heart.fill" : "heart"
        cell.isLikeButton.imageView?.image = UIImage(systemName: isLikeButtonImageName)
        
        return cell
        
    }
    
    // MARK: -  CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller = ProductViewController()
//        toNewController?.show(controller, sender: nil)
        
        print(indexPath)
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
