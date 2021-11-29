//
//  ResultCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/13.
//

import UIKit


class ResultCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myInit()
//        configureCellSize()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCellSize()
        
    }
    
    
    func myInit(){
        // 隠藏navigationBar的返回鈕的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        collectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
        collectionView.register(ProductListHAxisCell.nib(), forCellWithReuseIdentifier: ProductListHAxisCell.identifier)
        collectionView.backgroundColor = .systemGray3
    }
    
    // MARK: -  依layoutSytle改變Cell的寬高尺寸
    func configureCellSize() {
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = .zero
        var height = CGFloat.zero
        var width = CGFloat.zero
        // two cells in a row
        if Keywords.isHorizontalStyle {
            layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 10
            width = UIScreen.main.bounds.width
            height = 150

        } else {
            // one cell in a row
            layout?.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            layout?.minimumInteritemSpacing = 5
            layout?.minimumLineSpacing = 10
            width = (UIScreen.main.bounds.width - 30) / 2
            height = 300
        }
        layout?.itemSize = CGSize(width: width, height: height)
            
    }
    
    // MARK: -  layoutChange
    @IBAction func changeLayout(_ sender: UIBarButtonItem) {
        if Keywords.isHorizontalStyle {
            Keywords.isHorizontalStyle = false
        } else {
            Keywords.isHorizontalStyle = true
        }
        sender.image = UIImage(systemName: Keywords.resultCollectionViewlayoutStyle)
        collectionView.reloadData()
    }
    // MARK: UICollectionViewDataSource
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Products.demoRoom.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if Keywords.isHorizontalStyle {
            // one cell in a row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListHAxisCell.identifier, for: indexPath) as! ProductListHAxisCell
            return cell
           
        } else {
            // two cells in a row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
            return cell

        }
        
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var keyword = ""
//        if Keywords.isHorizontalStyle {
//            let cell = collectionView.cellForItem(at: indexPath) as! ResultAxisHCollectionViewCell
//            keyword = cell.resultNameLabel.text ?? ""
//
//        } else {
//            let cell = collectionView.cellForItem(at: indexPath) as! ResultCollectionViewCell
//            keyword = cell.resultNameLabel.text ?? ""
//
//        }
        // 設定選定的商品資料到Products.selectProduct
        Products.selectProduct = Products.demoRoom[indexPath.row]
        performSegue(withIdentifier: "toProductViewController", sender: keyword)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let productController = segue.destination as! ProductViewController
//        productController.title = sender as? String
    }
    
}
// MARK: -  2 type of Cell Delegate

//extension ResultCollectionViewController: ResultAxisHCollectionViewCellDelegate, ResultCollectionViewCellDelegate{
//    func didTapButton(cell: ResultAxisHCollectionViewCell) {
//        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
//        likeButtonClick(indexPath)
//    }
//
//    func didTapButton(cell: ResultCollectionViewCell) {
//        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
//        likeButtonClick(indexPath)
//    }
    
//    func likeButtonClick(_ indexPath: IndexPath){
//        // isLike按鈕被點擊之後, 將陣列內的isLike值設為反向, 更新isLike按鈕狀態
//        Products.demoRoom[indexPath.row].isLike = Products.demoRoom[indexPath.row].isLike ? false : true
//        self.collectionView.reloadItems(at: [indexPath])
//    }
//}
