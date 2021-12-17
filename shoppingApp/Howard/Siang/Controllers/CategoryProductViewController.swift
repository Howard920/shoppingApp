//
//  CategoryViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/9.
//

import UIKit

class CategoryProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.collectionView.alwaysBounceVertical = true
        productCollectionView.collectionView.bounces = true
        productCollectionView.collectionView.isScrollEnabled = true
        loadData()
    }
    
    private func loadData(){
        DatabaseHandler.getProduct(category: navigationItem.title! ,count: 10) { [weak self] items, images in
            self?.productCollectionView.itemData = items
            self?.productCollectionView.imageData = images
            DispatchQueue.main.async {
                self?.productCollectionView.collectionView.reloadData()
                self?.loadingView.isHidden = true
                self?.productCollectionView.isHidden = false
            }
        }
    }

}
