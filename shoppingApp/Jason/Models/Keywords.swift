//
//  Keywords.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/10.
//

import Foundation
struct Keywords {
    static var populayWords = ["蛋糕", "湯圓", "羊肉爐", "桂冠", "火鍋","可樂", "哈根達斯", "洋芋片", "彩虹糖", "棉花糖"]
    static var historyWords = ["書", "茶"]
    static let historyHeaderText = "歷史記錄"
    static let popularHeaderText = "熱門關鍵字"
    static let clearHistoryText = "清除歷史記錄"
    
    
    // cell identifier
    static let segueIdOfSearchResult = "toResultCollectionViewController"
    static let segueIdOfProductsDetail = "toProductsDetailViewController"

    
    static var isHorizontalStyle = true {
        didSet{
            Keywords.resultCollectionViewlayoutStyle = isHorizontalStyle ? "rectangle.grid.2x2" : "list.dash"
        }
    }
    static var resultCollectionViewlayoutStyle = "list.dash"    
    
    
    static let reuseCellIdentifierOfProduct = "\(ProductCollectionViewCell.self)"
    static let reuseCellIdentifierOfHorizontalStyle = "ResultAxisHCollectionViewCell"
    static let reuseCellIdentifierOfVerticalStyle = "ResultCollectionViewCell"
}


