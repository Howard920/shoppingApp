//
//  PageScrollView.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/28.
//

import UIKit

@IBDesignable
class PageScrollView: UIView, NibOwnerLoadable{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var contentViews: [UIView]!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageStackView: UIStackView!
    
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
        scrollView.delegate = self
        pageControl.numberOfPages =  pageStackView.subviews.count - 2
        
    }

}

extension PageScrollView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == scrollView.contentSize.width - self.frame.size.width{
            scrollView.contentOffset.x = self.frame.size.width
        }
        
        if scrollView.contentOffset.x == 0{
            scrollView.contentOffset.x = scrollView.contentSize.width - self.frame.size.width * 2
        }
        
        let currentPage = Int(scrollView.contentOffset.x/self.frame.size.width)
        if currentPage > pageControl.numberOfPages - 1{
            pageControl.currentPage = 0
        }else{
            pageControl.currentPage = currentPage
        }
        
        
    }
}

