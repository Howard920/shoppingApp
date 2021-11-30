//
//  BuyItemsListViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/29.
//

import UIKit

class BuyItemsListViewController: UIViewController {
    var numberOfItems = 6
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        layout.minimumInteritemSpacing = 10

        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 30) / 2 ,
            height: (UIScreen.main.bounds.width - 30) / 2 + 125
        )
        
        collectionView.collectionViewLayout = layout

        collectionView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")

        collectionView.dataSource = self
    }
}

extension BuyItemsListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        
        return cell
    }
    
    
}
