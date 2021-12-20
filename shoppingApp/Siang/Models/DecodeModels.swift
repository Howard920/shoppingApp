//
//  OrderCodable.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/8.
//

import Foundation

struct MemberCodable: Codable{
    var member_id_phone: String
    var password: String
    var name: String
    var gender: Int
    var birthday: String //yyyy-MM-dd
    var address: String
    var like_list:[Int]
}

struct OrderCodable: Codable{
    var order_id: Int
    var member_id_phone: String
    var price: Int
    var shipment: Shipment
    var payment: Payment
    var order_date: Date?
    var order_person_name: String?
    var order_person_phone: String?
    var order_person_address: String?
    var order_person_email: String?
    var product_list: [OrderProduct]{
        didSet{
            var price = 0
            for product in product_list{
                price += product.item.price
            }
            self.price = price
        }
    }
}

struct OrderProduct: Codable{
    var item_count: Int
    var item: ItemCodable
}

struct ItemCodable: Codable{
    var item_id: Int
    var name: String
    var price: Int
    var quantity: Int
    var detail: [String:String]
    var vendor_id: Int
    var media_info: URL
}

enum Payment: String, CaseIterable, Codable{
    case cash_on_delivery_convenice_store = "超商取貨付款"
    case apple_pay = "Apple Pay"
    case credit_card = "信用卡一次付清"
}

enum Shipment: String, CaseIterable, Codable{
    case seven_eleven = "7-11取貨"
    case family_mart = "全家取貨"
    case home_delivery = "宅配"
}
