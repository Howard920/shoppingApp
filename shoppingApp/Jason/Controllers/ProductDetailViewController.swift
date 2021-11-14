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
        configureCellSize()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // show tab bar
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func loadInit(){
        // hide tab bar
        self.tabBarController?.tabBar.isHidden = true
        
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
        // 設定Cell尺寸
        layout?.minimumInteritemSpacing = 20
        layout?.minimumLineSpacing = 30
        width = collectionView.bounds.width / 2 - 20
        height = collectionView.bounds.height / 2 - 60
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
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        return cell
    }
}
