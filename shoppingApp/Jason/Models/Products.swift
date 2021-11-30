//
//  Products.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/9.
//

import Foundation
import UIKit

struct Products {
    var name:String
    var price:Int
    var picture: Data?
    var isLike: Bool = false

    static var selectProduct: Products? = nil
    static var demoRoom:[Products] = [
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱, 超便宜, 買10箱再送一箱, 滿30箱再抽iPhone, 活動只到今天, 要買要快！！！", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
        Products(name: "[光泉]保久乳_果汁牛乳200ml*24/箱", price: 249, picture: UIImage(named: "milk")?.jpegData(compressionQuality: 0.8)),
    ]
}



