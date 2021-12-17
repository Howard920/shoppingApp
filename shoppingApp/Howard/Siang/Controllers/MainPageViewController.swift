//
//  ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/20.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet var categoryCollectionViews: [UICollectionView]!
    @IBOutlet weak var categoryPageControl: UIPageControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var productCollectionViewHeight: NSLayoutConstraint!
    
    private let fullScreenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setRelationShip()
        loadData()
        
    }
    
    private func setLayout(){
        
        //設定分類列表的排版
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: (fullScreenSize.width - 310)/6 + 5, bottom: 0, right: (fullScreenSize.width - 310)/6 + 5
        )
        layout.minimumInteritemSpacing = (fullScreenSize.width - 310)/6
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(
            width: 50,
            height: 70
        )
        categoryCollectionViews[0].collectionViewLayout = layout
        categoryCollectionViews[1].collectionViewLayout = layout
    
        //12個商品對應的長度
        productCollectionViewHeight.constant = (((UIScreen.main.bounds.width - 30) / 2 + 125) + 10) * 12/2
        
        //載入中提醒畫面外觀
        loadingView.layer.cornerRadius = 5
        loadingView.clipsToBounds = true
        
        //主畫面隱藏
        containerScrollView.isHidden = true
    }
    
    private func setRelationShip(){
        categoryCollectionViews[0].register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionViews[1].register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        categoryCollectionViews[0].dataSource = self
        categoryCollectionViews[1].dataSource = self
        categoryCollectionViews[0].delegate = self
        categoryCollectionViews[1].delegate = self
        
        productCollectionView.cellDelegate = self
    }
    
    private func loadData(){
        //載入12個商品的資料
        DatabaseHandler.getProduct(count: 12) { [weak self] items, images in
            DispatchQueue.main.async {
                self?.productCollectionView.itemData = items
                self?.productCollectionView.imageData = images
                self?.productCollectionView.collectionView.reloadData()
                self?.loadingView.isHidden = true
                self?.containerScrollView.isHidden = false
            }
        }
    }
   
}

//MARK: - UICollectionViewDataSource Methods

extension MainPageViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        if collectionView == categoryCollectionViews[0]{
            cell.titleLabel.text = Constants.categories[indexPath.row].title
            cell.imageView.image = Constants.categories[indexPath.row].image
        }else{
            cell.titleLabel.text = Constants.categories[indexPath.row + 10].title
            cell.imageView.image = Constants.categories[indexPath.row + 10].image
        }
        
        
        return cell
    }
}

//MARK: - UIScrollViewDelegate Methods

extension MainPageViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == categoryScrollView{
            if scrollView.contentOffset.x == 0{
                categoryPageControl.currentPage = 0
            }
            
            if scrollView.contentOffset.x == categoryScrollView.bounds.width {
                categoryPageControl.currentPage = 1
            }
        }
    }
}

//MARK: - UICollectionViewDelegate Methods

extension MainPageViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CategoryProductViewController
        
        if let index = categoryCollectionViews[0].indexPathsForSelectedItems?[0]{
            let cell = categoryCollectionViews[0].cellForItem(at: index) as! CategoryCell
            destinationVC.navigationItem.title = cell.titleLabel.text
        }else{
            let index = categoryCollectionViews[1].indexPathsForSelectedItems![0]
            let cell = categoryCollectionViews[1].cellForItem(at: index) as! CategoryCell
            destinationVC.navigationItem.title = cell.titleLabel.text
        }

    }
}

extension MainPageViewController: ProductCellDelegate{
    
    func addingToCart() {

    }
    
    func successfullyAddToCart() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "MainPage", bundle: nil)
            let myAlert = storyboard.instantiateViewController(withIdentifier: "alert")
            myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    func productAddToFavorite(item_id: Int) {
        
    }
}

