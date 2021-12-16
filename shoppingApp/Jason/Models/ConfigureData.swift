//
//  ConfigureData.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/5.
//

import Foundation
enum TypeOfButton: Int {
    case addTocart = 0
    case addToFavorite
    case cart
}

struct UserInfo {
    static var cartList:[Int] = []
    static var favoriteList: [Int] = []
//    static var selectedProduct: ProductInfo?
//    static var productLayoutStyle = ""
    static var isLogin = false
    static var member_id_phone = "0900000000"{
        didSet{
            isLogin = member_id_phone.isEmpty ? false : true
        }
    }
}

struct MemberPage {
    static let cellTitle = ["訂單查詢", "基本資料", "修改密碼", "買過的商品", "登出",]
    static let InfoTitle = ["手機號碼", "姓名", "生日", "性別", "通訊地址"]
}

struct SearchPage {
    static var populayWords = ["蛋糕", "湯圓", "羊肉爐", "桂冠", "火鍋","可樂", "哈根達斯", "洋芋片", "彩虹糖", "棉花糖"]
    static var productWords = ["牛奶 1000ml", "果汁", "熱狗", "茶葉蛋", "地瓜", "哈根達斯 冰棒 口味",]
    static var labelCellWords:[String] = []
    static var historyWords:[String] = []
    static let historyHeaderText = "歷史記錄"
    static let popularHeaderText = "熱門關鍵字"
    static let clearHistoryText = "清除歷史記錄"
    
    // cell identifier
    static let segueIdOfSearchResult = "toResultCollectionViewController"
    static let segueIdOfProductsDetail = "toProductsDetailViewController"
    static var cellStyleButtonImageName = "rectangle.grid.2x2"
    static var isCellListLayout:Bool = true {
        didSet {
            cellStyleButtonImageName = isCellListLayout ? "rectangle.grid.2x2" : "list.dash"
        }
    }
}
