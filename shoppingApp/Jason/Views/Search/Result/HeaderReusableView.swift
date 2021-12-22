//
//  HeaderReusableView.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/6.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    static let identifier: String = "HeaderReusableView"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
