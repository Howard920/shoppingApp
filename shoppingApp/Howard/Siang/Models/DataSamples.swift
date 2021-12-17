//
//  ProductSiang.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/24.
//

import Foundation
import UIKit

struct OrderSiang{  //order_list
    
    var customer = CustomerSiang()
    var price =  Observable<Int>(value: 0)
    var payment: Payment = .cash_on_delivery_convenice_store
    var ship: Shipment = .seven_eleven
    var orderItems = [OrderItem](){
        didSet{
            var totalPrice = 0
            for item in orderItems{
                totalPrice += item.product.price * item.num
            }
            price.value = totalPrice
        }
    }
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

struct ProductSiang{
    let id = UUID()
    var name: String
    var price: Int
    var image: UIImage
}

struct OrderItem{
    let product: ProductSiang
    var num = 1
}

struct CustomerSiang {
    var name: String?
    var phone:String?
    var address: String?
    var email: String?
}



struct ProductSamples{
    static var productSample1 = ProductSiang(name: "[亞尼克]厚。巧克力生乳捲，414g/條，共16條", price: 1480, image: UIImage(named: "productSample")!)
    static var productSample2 = ProductSiang(name: "【晟品凍洋】極凍超厚切鮭魚，400g±10%/包*10包"
    , price: 2750, image: UIImage(named: "productSample2")!)
    static var productSample3 = ProductSiang(name: "【Samsung】三星Galaxy智慧手錶，Watch4 BT 44mm R870"
    , price: 9990, image: UIImage(named: "productSample3")!)
}


