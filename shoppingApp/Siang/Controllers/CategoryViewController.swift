//
//  CategoryViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/9.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var collectionVMangeView: CategoryProductCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVMangeView.collectionView.alwaysBounceVertical = true
        collectionVMangeView.collectionView.bounces = true
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
