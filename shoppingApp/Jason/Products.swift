//
//  Products.swift
//  HappyShop
//
//  Created by jason on 2021/10/21.
//

import Foundation
import UIKit
struct Products {
    let name: String
    let price: Int
    let picture: String?
    let category: Category
    static var getData:String{
        ""
    }

    
    
    
    
    
    
    static var testData:[Products]{[
            Products(name: "apple", price: 20, picture: "apple", category: .fruit),
            Products(name: "banana", price: 18, picture: "banana", category: .fruit),
            Products(name: "mangomangomangomangomangomangomangomangomangomangomangomangomangomangomangomangomangomangomango", price: 80, picture: nil, category: .fruit),
            Products(name: "pineapple", price: 45, picture: "pineapple", category: .fruit),
            Products(name: "grape", price: 60, picture: "grape", category: .vegetable),
            Products(name: "cherry", price: 120, picture: "cherry", category: .vegetable),
            Products(name: "kiwi", price: 18, picture: "kiwi", category: .vegetable),
            Products(name: "peach", price: 70, picture: "peach", category: .vegetable),
        Products(name: "blueberry", price: 70, picture: "blueberry", category: .vegetable),
        Products(name: "strawberry", price: 70, picture: "strawberry", category: .vegetable)
            ]
        
    }
}

enum Category {
    case fruit, vegetable
}
