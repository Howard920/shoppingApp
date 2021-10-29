//
//  TestViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/29.
//

import UIKit

class TestViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageScrollView: PageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        //trigger scrollViewDidScroll method
        pageScrollView.scrollView.contentOffset.x = 1
    }

}
