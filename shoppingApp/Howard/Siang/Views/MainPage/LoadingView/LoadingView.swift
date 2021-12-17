//
//  LoadingView.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/9.
//

import UIKit

class LoadingView: UIView, NibOwnerLoadable{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        
    }
}
