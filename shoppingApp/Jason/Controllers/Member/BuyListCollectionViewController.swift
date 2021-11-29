//
//  BuyListCollectionViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/27.
//

import UIKit

class BuyListCollectionViewController: UICollectionViewController {

    var infoButtonState:[Bool] = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BuyListHeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BuyListHeaderCollectionReusableView.identifier)
        
        collectionView!.register(BuyListInfoCellCollectionViewCell.nib(), forCellWithReuseIdentifier: BuyListInfoCellCollectionViewCell.identifier)
    }
    
    
    @objc func moreInfo(_ sender: UIButton){
        let section = sender.tag
        infoButtonState[section] = !infoButtonState[section]
        collectionView.reloadSections(IndexSet(integer: section))
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if infoButtonState[section] {
            return 2
        } else {
            return 0

        }
    }
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BuyListHeaderCollectionReusableView.identifier, for: indexPath) as! BuyListHeaderCollectionReusableView
        headerView.moreInfoButton.tag = indexPath.section
        headerView.moreInfoButton.addTarget(self, action: #selector(moreInfo(_:)), for: .touchUpInside)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       
        return configureCellSize()
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuyListInfoCellCollectionViewCell.identifier, for: indexPath) as! BuyListInfoCellCollectionViewCell
        return cell
    }

    private func configureCellSize(_ style: Int = 0) -> CGSize {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        var customSize = CGSize.zero
        // section layout
        if style == 0 {
            // 設定Cell尺寸
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 0
            customSize.width = UIScreen.main.bounds.width
            customSize.height = 200
        } else { // cell layout
            // 設定Cell尺寸
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 1
            customSize.width = UIScreen.main.bounds.width - 20
            customSize.height = 300
        }
        
        return customSize
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }

}

extension BuyListCollectionViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return configureCellSize(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }

}
