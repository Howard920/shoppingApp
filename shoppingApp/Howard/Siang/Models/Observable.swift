//
//  Observable.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/5.
//

import Foundation

class Observable <T>{
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
    init(value: T){
        self.value = value
    }
    
}
