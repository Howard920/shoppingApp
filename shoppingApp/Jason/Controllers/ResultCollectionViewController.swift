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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCellSize()
    }
    
    // MARK: -  依layoutSytle改變Cell的寬高尺寸
    func configureCellSize() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = .zero
        var height = CGFloat.zero
        var width = CGFloat.zero
        // two cells in a row
        if Keywords.isHorizontalStyle {
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 0
            height = collectionView.bounds.height / 5
            width = collectionView.bounds.width
            
        } else {
            // one cell in a row
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 0
            width = collectionView.bounds.width / 2
            height = collectionView.bounds.height / 2 - 60
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Products.demoRoom.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if Keywords.isHorizontalStyle {
            // one cell in a row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Keywords.reuseCellIdentifierOfHorizontalStyle, for: indexPath) as! ResultAxisHCollectionViewCell
            cell.setup(indexPath)
            cell.delegate = self
            return cell
            
        } else {
            // two cells in a row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Keywords.reuseCellIdentifierOfVerticalStyle, for: indexPath) as! ResultCollectionViewCell
            cell.setup(indexPath)
            cell.delegate = self
            return cell
        }
        
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var keyword = ""
        if Keywords.isHorizontalStyle {
            let cell = collectionView.cellForItem(at: indexPath) as! ResultAxisHCollectionViewCell
            keyword = cell.resultNameLabel.text ?? ""
            
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ResultCollectionViewCell
            keyword = cell.resultNameLabel.text ?? ""
            
        }
//        performSegue(withIdentifier: Keywords.segueIdOfProductsDetail, sender: keyword)
        performSegue(withIdentifier: "toProductViewController", sender: keyword)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productController = segue.destination as! ProductViewController
        productController.title = sender as? String
//        let productsDetailTableViewController = segue.destination as! ProductDetailViewController
        
        
//        productsDetailTableViewController.title = sender as? String
    }
    
}
// MARK: -  2 type of Cell Delegate

extension ResultCollectionViewController: ResultAxisHCollectionViewCellDelegate, ResultCollectionViewCellDelegate{
    func didTapButton(cell: ResultAxisHCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        likeButtonClick(indexPath)
    }
    
    func didTapButton(cell: ResultCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        likeButtonClick(indexPath)
    }
    
    func likeButtonClick(_ indexPath: IndexPath){
        // isLike按鈕被點擊之後, 將陣列內的isLike值設為反向, 更新isLike按鈕狀態
        Products.demoRoom[indexPath.row].isLike = Products.demoRoom[indexPath.row].isLike ? false : true
        self.collectionView.reloadItems(at: [indexPath])
    }
}
