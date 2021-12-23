//
//  Calculator.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/6.
//

import Foundation
import UIKit

class Common {
    static let favorite = "已收藏"
    static let unfavorite = "取消收藏"
    static let cart = "加入購物車"
    static let uncart = "從購物車移除"
    static let user = UserDefaults.standard
    static var member:Member?{
        didSet{
            if let member_id_phone = member?.member_id_phone {
                UserInfo.member_id_phone = member_id_phone
            }
            if let favoriteList = member?.like_list {
                UserInfo.favoriteList = favoriteList
            }
        }
    }
    
    static func addItemToCart(_ product: ProductInfo){
        let item: ItemCodable = ItemCodable.init(
            item_id: product.item_id,
            name: product.name,
            price: product.price,
            quantity: product.quantity ?? 0,
            detail: product.detail ?? [:],
            vendor_id: product.vendor_id ?? 0,
            media_info: URL(string:product.media_info ?? "")!)
        let orderProduct = OrderProduct(add_time: Date.get_add_time(), item_count: 1, item: item)
        cartSystem.updateCartProduct(product: orderProduct) { (_) in
        }
        
        
    }
    
    static func saveMember(){
        member?.member_id_phone =  UserInfo.member_id_phone
        member?.like_list = UserInfo.favoriteList
        guard let member = try? JSONEncoder().encode(member) else {return}
        user.setValue(member, forKey: "member")
    }
    static func getMember() -> Member?{
        guard let readMember =  user.object(forKey: "member") as? Data else {return nil}
        print("readMember", readMember)
        let member = try? JSONDecoder().decode(Member.self, from: readMember)
        return member
    }
    // 利用String類別的bonudingRect方法來取得文字的高度, 寬度
    static func getStringSize(withText text: String, width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect: CGSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox: CGSize = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        return boundingBox
    }
    
    static func autoDisapperAlert(_ controller: UIViewController, message: String , duration: Double = 0.35){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { [weak controller] in
                guard controller?.presentedViewController == alert else { return }
                
                controller?.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}




enum TypeOfButton: Int {
    case addTocart = 0
    case addToFavorite
    case cart
}

struct UserInfo {
    static var cartList:[Int] = []
    static var favoriteList: [Int] = [] {
            didSet {
                favoriteSystem.favoriteList = favoriteList
            }
        }
    static var isLogin = false
    static var member_id_phone = "0900000000"{
        didSet{
            isLogin = member_id_phone.isEmpty ? false : true
                
                favoriteSystem.getFavoriteList { error in
                    
                }
            
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
    static let segueIdOfSearchResult = "ResultCollectionViewController"
    static let segueIdOfProductsDetail = "ProductViewController"
    static var cellStyleButtonImageName = "rectangle.grid.2x2"
    static var isCellListLayout:Bool = true {
        didSet {
            cellStyleButtonImageName = isCellListLayout ? "rectangle.grid.2x2" : "list.dash"
        }
    }
}
