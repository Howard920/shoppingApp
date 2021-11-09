//
//  homeProductCollectionView.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/28.
//

import UIKit

class CategoryProductCollectionView: ProductCollectionView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.isScrollEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        collectionView.isScrollEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
//        cell.imageHeightConstraint.constant = (self.frame.width - 30) / 2
        
        return cell
    }
}
