//
//  CartStepView.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import Foundation
import UIKit

class CartStepView: UIView, NibOwnerLoadable{
    
    @IBOutlet var stepLabels: [UILabel]!
    @IBOutlet var stepBars: [UIView]!
    
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
    
}
