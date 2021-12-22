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
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        layout.minimumInteritemSpacing = 10

        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 30) / 2 ,
            height: (UIScreen.main.bounds.width - 30) / 2 + 125
        )
        collectionView.collectionViewLayout = layout
    }
    
    private func setRelationShip(){
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
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

