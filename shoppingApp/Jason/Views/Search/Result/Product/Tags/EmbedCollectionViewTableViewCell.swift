//
//  EmbedCollectionViewTableViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/19.
//

import UIKit

protocol  EmbedCollectionViewTableViewCellDelegae: AnyObject{
    func didTap(_ keyword: String)
}
class EmbedCollectionViewTableViewCell: UITableViewCell {
    static let identifier: String = "EmbedCollectionViewTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var lableDelegate: EmbedCollectionViewTableViewCellDelegae?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(LabelCollectionViewCell.nib(), forCellWithReuseIdentifier: LabelCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
}

extension EmbedCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: -  CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchPage.labelCellWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as! LabelCollectionViewCell
        cell.configure(SearchPage.labelCellWords[indexPath.row])
        return cell
    }
    
    // MARK: -  CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lableDelegate?.didTap(SearchPage.labelCellWords[indexPath.row])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let myTxt = SearchPage.labelCellWords[indexPath.row]
        
        // 利用String類別的bonudingRect方法來取得文字的高度
        var cellSize = Common.getStringSize(withText: myTxt, width: 300, font: .systemFont(ofSize: 17))
        layout?.estimatedItemSize = .zero
        layout?.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        cellSize.width += 10
        cellSize.height = 40
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }

}
