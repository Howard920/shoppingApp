//
//  ProductsDetailViewController.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/14.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInit()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        configureCellSize()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // show tab bar
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func loadInit(){
        // hide tab bar
        self.tabBarController?.tabBar.isHidden = true
        collectionView.register(UINib(nibName: Keywords.reuseCellIdentifierOfProduct, bundle: nil), forCellWithReuseIdentifier: Keywords.reuseCellIdentifierOfProduct)
        // collectionView delegate datasource set
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 設定 加入購物車 按鈕的邊框, 邊框顏色, 圓角, 是否開啟圓角
//        addToCartButton.layer.borderWidth = 2
//        addToCartButton.layer.borderColor = UIColor.systemRed.cgColor
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.clipsToBounds = true
        // 設定 立即結帳 按鈕的邊框, 邊框顏色, 圓角, 是否開啟圓角
//        checkOutButton.layer.borderWidth = 2
//        checkOutButton.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        checkOutButton.layer.cornerRadius = 15
        checkOutButton.clipsToBounds = true
        
        // cart button
        cartButton.addSubview(badgeLabel())
       
    }
    
    // 購物車右上角的小數字
    private func badgeLabel() -> UIView{
        let badgeCount = UILabel(frame: CGRect(x: 33, y: -12, width: 20, height: 20))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 2
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .red
        badgeCount.text = "99"
        return badgeCount
    }
    
    private func configureCellSize() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = .zero
        var height = CGFloat.zero
        var width = CGFloat.zero
        // 設定Cell間距
        layout?.minimumInteritemSpacing = 20
        layout?.minimumLineSpacing = 30
        // 取得Device寬度
        width = CGFloat(UIScreen.main.bounds.width)
        height = CGFloat(UIScreen.main.bounds.height) / 1.5
        // 設定cell尺寸
        layout?.itemSize = CGSize(width: width, height: height)
    }
}
// MARK: -  CollectionView Delegate

extension ProductDetailViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
// MARK: -  collectionView Data Source
extension ProductDetailViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Keywords.reuseCellIdentifierOfProduct, for: indexPath) as! ProductCollectionViewCell
        return cell
    }
    
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("sizeForItemAt sizeForItemAt" , indexPath)
        let width = CGFloat(UIScreen.main.bounds.width)
        let height = CGFloat(UIScreen.main.bounds.height) / 1.5
        
        return  CGSize(width: width, height: height)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
}
