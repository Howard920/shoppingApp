//
//  CategoryViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/9.
//

import UIKit
//ellStyleButtonImageName = isCellListLayout ? "rectangle.grid.2x2" : "list.dash"
class CategoryProductViewController: UIViewController, UICollectionViewDelegate{

    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.cellDelegate = self
        productCollectionView.collectionView.delegate = self
        productCollectionView.collectionView.alwaysBounceVertical = true
        productCollectionView.collectionView.bounces = true
        productCollectionView.collectionView.isScrollEnabled = true
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.productCollectionView.collectionView.reloadData()
    }
    
    @IBAction func layoutButtonPressed(_ sender: UIBarButtonItem) {
        
        productCollectionView.isLayoutGrid = !productCollectionView.isLayoutGrid
        
        if productCollectionView.isLayoutGrid{
            sender.image = UIImage(systemName: "list.dash")
            productCollectionView.collectionView.reloadData()
            productCollectionView.collectionView.setCollectionViewLayout(productCollectionView.layoutGrid, animated: false)

        }else{
            sender.image = UIImage(systemName: "rectangle.grid.2x2")
            productCollectionView.collectionView.reloadData()
            productCollectionView.collectionView.setCollectionViewLayout(productCollectionView.layoutList, animated: false)
        }
        

    }
    
    private func loadData(){
        DatabaseHandler.getProduct(category: navigationItem.title! ,count: 10) { [weak self] items in
            self?.productCollectionView.itemData = items
//            self?.productCollectionView.imageData = images
            self?.productCollectionView.imageData = [UIImage?](repeating: nil, count: items.count)
            DispatchQueue.main.async {
                self?.productCollectionView.collectionView.reloadData()
                self?.loadingView.isHidden = true
                self?.productCollectionView.isHidden = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Cooperative.goProductVC(rootVC: self, item: productCollectionView.itemData[indexPath.row])
    }
}

extension CategoryProductViewController: ProductCellDelegate{
    
    func successfullyAddToCart() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            let myAlert = storyboard.instantiateViewController(withIdentifier: "alert")
            myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    func productAddToFavorite() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            let myAlert = storyboard.instantiateViewController(withIdentifier: "alert") as! AlertViewController
            myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            myAlert.alertText = "加入收藏 ！"
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    func productDeleteFromFavorite() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            let myAlert = storyboard.instantiateViewController(withIdentifier: "alert") as! AlertViewController
            myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            myAlert.alertText = "取消收藏 ！"
            self.present(myAlert, animated: true, completion: nil)
        }
    }
}
