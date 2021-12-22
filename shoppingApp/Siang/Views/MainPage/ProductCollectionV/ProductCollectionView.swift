//
//  ProductCollectionView.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/27.
//

import UIKit

class ProductCollectionView: UIView, NibOwnerLoadable{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var itemData = [ItemCodable]()
    var imageData = [UIImage?]()
    weak var cellDelegate: ProductCellDelegate?
    let layoutList = UICollectionViewFlowLayout()
    let layoutGrid = UICollectionViewFlowLayout()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit(){
        loadNibContent()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        setRelationShip()
    }
    
    private func setLayout(){
        
        layoutGrid.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        layoutGrid.minimumInteritemSpacing = 10

        layoutGrid.minimumLineSpacing = 10
        layoutGrid.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 30) / 2 ,
            height: (UIScreen.main.bounds.width - 30) / 2 + 125
        )
        collectionView.collectionViewLayout = layoutGrid
        
        layoutList.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        layoutList.minimumInteritemSpacing = 0

        layoutList.minimumLineSpacing = 0
        layoutList.itemSize = CGSize(
            width: UIScreen.main.bounds.width - 10,
            height: 150
        )
    }
    
    private func setRelationShip(){
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(UINib(nibName: "ProductCell2", bundle: nil), forCellWithReuseIdentifier: "ProductCell2")
        collectionView.dataSource = self
    }
}
 //MARK: - UICollectionViewDataSource Methods

extension ProductCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let identifier = collectionView.collectionViewLayout == layoutGrid ? "ProductCell":"ProductCell2"
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProductCell
        cell.setItemCell(item: itemData[row], image: imageData[row], delegate: cellDelegate)
        
        if self.imageData[row] == nil{
            DatabaseHandler.fetchImage(url: itemData[row].media_info) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageData[row] = image
                    self?.collectionView.reloadItems(at: [indexPath])
                }
               
            }
        }
        
        return cell
    }
    
}

