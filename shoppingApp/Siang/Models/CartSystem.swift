//
//  CartSystem.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/14.
//

import UIKit

let cartSystem = CartSystem()

class CartSystem{
    
    var productImages = [UIImage?]()
    var cart:OrderCodable!
    
    
    func deleteCartProduct(at row: Int, completionHandler: @escaping (Error?)->Void){
        
        let order_id = cart.order_id
        let item_id = cart.product_list[row].item.item_id
        let item_count = 0
        
        let url = URL(string: "\(NetWorkHandler.host)/order_product?order_id=\(order_id)&item_id=\(item_id)&item_count=\(item_count)")!
        let request = URLRequest(url: url)//待更改
        let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
            getCart {
                productImages.remove(at: row)
                completionHandler(error)
            }
        }
        
        task.resume()
    }
    
    func updateCartProduct(product: OrderProduct, completionHandler: @escaping (Error?)->Void){
        
        let order_id = cart.order_id
        let item_id = product.item.item_id
        let item_count = product.item_count
        let add_time = product.add_time
        
        let url = URL(string: "\(NetWorkHandler.host)/order_product?order_id=\(order_id)&item_id=\(item_id)&item_count=\(item_count)&add_time=\(add_time)")!
        let request = URLRequest(url: url)//待更改
        let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
            getCart {
                completionHandler(error)
            }
        }
        
        task.resume()
    }
    
    func updateCart(shipment: Shipment?, payment:Payment?, completionHandler: @escaping (Error?)->Void){
        let order_id = cart.order_id
        if shipment != nil{
            let encodingStr = "\(NetWorkHandler.host)/updateOrder?order_id=\(order_id)&shipment=\(shipment!.rawValue)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: encodingStr!)!
            let request = URLRequest(url: url)//待更改
            let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
                getCart {
                    completionHandler(error)
                }
            }
            task.resume()
        }
        
        if payment != nil{
            let encodingStr = "\(NetWorkHandler.host)/updateOrder?order_id=\(order_id)&payment=\(payment!.rawValue)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: encodingStr!)!
            let request = URLRequest(url: url)//待更改
            let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
                getCart {
                    completionHandler(error)
                }
            }
            task.resume()
        }
    }
    
    func sendCart(name: String, phone: String, address: String, mail: String?, completionHandler: @escaping (Error?)->Void){
        var encodingStr = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm"
        let dateStr = formatter.string(from: Date())
        if mail != nil{
            encodingStr = "\(NetWorkHandler.host)/updateOrder?order_id=\(cart.order_id)&date=\(dateStr)&name=\(name)&phone=\(phone)&address=\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }else{
            encodingStr = "\(NetWorkHandler.host)/updateOrder?order_id=\(cart.order_id)date=\(dateStr)&name=\(name)&phone=\(phone)&address=\(address)&mail=\(mail!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        let url = URL(string: encodingStr)!
        let request = URLRequest(url: url)//待更改
        let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
            if error != nil{
                fatalError()
            }
            newCart {
                completionHandler(error)
            }
        }
        task.resume()
        
    }
    
    func newCart(completionHandler: @escaping ()->Void){
        let url = URL(string: "\(NetWorkHandler.host)/newCart?member_id_phone=\(UserInfo.member_id_phone)")!
        let request = URLRequest(url: url)//待更改
        let task = URLSession.shared.dataTask(with: request) {[unowned self] data, response, error in
            getCart {
                completionHandler()
            }
        }
        task.resume()
    }
    
    func getCart(completionHandler: @escaping ()->Void){
        let url = URL(string: "\(NetWorkHandler.host)/getCart?member_id_phone=\(UserInfo.member_id_phone)")!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [unowned self] data, response, error in
//            guard let newCart = DatabaseHandler.parseJson(data!) as OrderCodable? else{
//                fatalError()
//            }
            
            self.cart = DatabaseHandler.parseJson(data!)
            if self.cart == nil{
                fatalError("開啟購物車失敗")
            }
            completionHandler()
//            if cart.product_list.count == 0{
//                completionHandler()
//            }
//            productImages = [UIImage?](repeating: nil, count: cart.product_list.count)
//            for (index,product) in cart.product_list.enumerated(){
//                DatabaseHandler.fetchImage(url: product.item.media_info) { image in
//                    productImages[index] = image
//                    for i in 0...cart.product_list.count - 1{
//                        if productImages[i] == nil{
//                            return
//                        }
//                    }
//                    completionHandler()
//                }
//            }
        }
        
        task.resume()
    }
    
    func reloadCartImages(completionHandler: @escaping ()->Void){
        if cart.product_list.count == 0{
            completionHandler()
        }
        productImages = [UIImage?](repeating: nil, count: cart.product_list.count)
        for (index,product) in cart.product_list.enumerated(){
            DatabaseHandler.fetchImage(url: product.item.media_info) { [unowned self] image in
                productImages[index] = image
                for i in 0...cart.product_list.count - 1{
                    if productImages[i] == nil{
                        return
                    }
                }
                completionHandler()
            }
        }

    }
}
