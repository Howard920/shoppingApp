//
//  LabelCollectionViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/19.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var keywordLabel: UILabel!
    static let identifier: String = "LabelCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellConfigure()
    }
    
    private func cellConfigure(){
        // 設定cell顏色 圓角
        self.backgroundColor = .systemGroupedBackground
        self.layer.cornerRadius = keywordLabel.bounds.height / 4
        self.clipsToBounds = true
        
    }

    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    func configure(_ title: String){
        keywordLabel.text = title
    }
}
