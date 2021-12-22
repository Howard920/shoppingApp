//
//  DatabaseTableList.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/2.
//

import Foundation

struct ReturnItems: Codable{
    var member_id_phone: String
    var order_id: Int
    var item_id: Int
    var item_count: Int
    var state: String?
}

struct CategoryTags: Codable{
    var name: [String]
}

struct PopularKeywords: Codable{
    var name: String
    var count: Int
}

struct ProductInfo: Codable, Hashable {
    var item_id: Int
    var name: String
    var price: Int
    var quantity : Int?
    var detail: [String:String]?
    var vendor_id: Int?
    var media_info: String?
    var payment: [String]?
    var delivery: [String]?
    
    var result:[ProductInfo]?
}

struct Member: Codable {
    var member_id_phone : String
    var password: String
    var name: String?
    var gender: Int?
    var birthday : String?
    var address: String?
    var buy_list: [Int]?
    var like_list : [Int]?
}

struct VendorInfo: Codable {
    var vendor_id: Int
    var name: String
    var address: String
    var phone: Int
    var logo: String
    var contact: String
    var payment: String
}

struct OrderInfo: Codable {
    var order_id : Int
    var member_id_phone: String
    var price : Int
    var shipment: String
    var payment: String
    var order_date: String
    var order_person_name: String
    var order_person_phone: String
    var order_person_address: String
    var order_person_email: String?
    var product_list: [ProductList]

    struct ProductList: Codable {
        var item_count: Int
        var item: ProductInfo
    }
}


