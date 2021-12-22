//
//  ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/20.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var pageScrollView: PageScrollView!
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet var categoryCollectionViews: [UICollectionView]!
    @IBOutlet weak var categoryPageControl: UIPageControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var productCollectionViewHeight: NSLayoutConstraint!
    
    private let fullScreenSize = UIScreen.main.bounds.size
    private var categoryTitleSelected: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setRelationShip()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.productCollectionView.collectionView.reloadData()
        self.pageScrollView.scrollView.contentOffset.x = 0
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
        productCollectionView.collectionView.delegate = self
    }
    
    private func loadData(){
        //載入12個商品的資料
        DatabaseHandler.getProduct(count: 12) { [weak self] items in
            DispatchQueue.main.async {
                self?.productCollectionView.itemData = items
//                self?.productCollectionView.imageData = images
                self?.productCollectionView.imageData = [UIImage?](repeating: nil, count: items.count)
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
        let categoryIndex = collectionView == categoryCollectionViews[0] ? indexPath.row : indexPath.row + 10
        cell.titleLabel.text = Constants.categories[categoryIndex].title
        cell.imageView.image = Constants.categories[categoryIndex].image
        
        return cell
    }
}

//MARK: - UIPageControl for categoryScrollView

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

//MARK: - To other pages

extension MainPageViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionViews[0] {
            let cell = categoryCollectionViews[0].cellForItem(at: indexPath) as! CategoryCell
            categoryTitleSelected = cell.titleLabel.text
            performSegue(withIdentifier: "goToCategory", sender: self)
        }else if collectionView == categoryCollectionViews[1]{
            let cell = categoryCollectionViews[1].cellForItem(at: indexPath) as! CategoryCell
            categoryTitleSelected = cell.titleLabel.text
            performSegue(withIdentifier: "goToCategory", sender: self)
        }else{
            Cooperative.goProductVC(rootVC: self, item: productCollectionView.itemData[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CategoryProductViewController
        destinationVC.navigationItem.title = categoryTitleSelected
    }
}

//MARK: - ProductCellDelegate Methods

extension MainPageViewController: ProductCellDelegate{

    func successfullyAddToCart() {
        presentAlert(title: "    已加入購物車 ！")
    }
    
    func productAddToFavorite() {
        presentAlert(title: "加入收藏 ！")
    }
    
    func productDeleteFromFavorite() {
        presentAlert(title: "取消收藏 ！")
    }
    
    private func presentAlert(title: String){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            let myAlert = storyboard.instantiateViewController(withIdentifier: "alert") as! AlertViewController
            myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            myAlert.alertText = title
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
}

