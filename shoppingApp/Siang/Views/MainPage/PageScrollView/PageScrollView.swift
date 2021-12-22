//
//  PageScrollView.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/28.
//

import UIKit

class PageScrollView: UIView, NibOwnerLoadable{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageStackView: UIStackView!
    
    private var timer: Timer!{
        didSet{
            oldValue?.invalidate()
        }
    }
    
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
        setTimer()
    }
    
    @objc func adChange(){
        let offset = CGPoint(x: scrollView.contentOffset.x + self.frame.width , y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    private func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(adChange), userInfo: nil, repeats: true)
    }

}

extension PageScrollView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Timer重數
        if scrollView.isDragging || scrollView.isDecelerating{
            setTimer()
        }
        //最後一頁->第二頁
        if scrollView.contentOffset.x == scrollView.contentSize.width - self.frame.size.width{
            scrollView.contentOffset.x = self.frame.size.width
        }
        //第一頁->倒數第二頁
        if scrollView.contentOffset.x == 0{
            scrollView.contentOffset.x = scrollView.contentSize.width - self.frame.size.width * 2
        }
        
        let currentPage = Int(scrollView.contentOffset.x/self.frame.size.width)
        pageControl.currentPage = currentPage
        
        //倒數第二頁實際上是第一頁
        if currentPage > pageControl.numberOfPages - 1{
            pageControl.currentPage = 0
        }else{
            pageControl.currentPage = currentPage
        }
    }
}

