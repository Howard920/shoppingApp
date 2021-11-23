//
//  CategoryViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/9.
//

import UIKit

class CategoryProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: ProductCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.collectionView.alwaysBounceVertical = true
        productCollectionView.collectionView.bounces = true
        productCollectionView.collectionView.isScrollEnabled = true
        productCollectionView.numberOfItems = 12
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
