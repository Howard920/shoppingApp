//
//  Keywords.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/10.
//

import Foundation
struct Keywords {
    static var populayWords = ["蛋糕", "湯圓", "羊肉爐", "桂冠", "火鍋","可樂", "哈根達斯", "洋芋片", "彩虹糖", "棉花糖"]
    static var productWords = ["牛奶 1000ml", "果汁", "熱狗", "茶葉蛋", "地瓜", "哈根達斯 冰棒 口味",]
    static var historyWords:[String] = []
    static let historyHeaderText = "歷史記錄"
    static let popularHeaderText = "熱門關鍵字"
    static let clearHistoryText = "清除歷史記錄"
    
    static var collectionCellTypeOfProductPage: ProductCellTypes = .keywords
    // cell identifier
    static let segueIdOfSearchResult = "toResultCollectionViewController"
    static let segueIdOfProductsDetail = "toProductsDetailViewController"

    
    static var isHorizontalStyle = true {
        didSet{
            Keywords.resultCollectionViewlayoutStyle = isHorizontalStyle ? "rectangle.grid.2x2" : "list.dash"
        }
    }
    static var resultCollectionViewlayoutStyle = "list.dash"    
}

enum ProductCellTypes {
    case keywords
    case info
    case payment
    case moreProduct
}


