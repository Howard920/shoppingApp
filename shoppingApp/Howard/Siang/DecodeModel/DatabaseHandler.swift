//
//  APIManeger.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/8.
//

import Foundation
import UIKit

class DatabaseHandler{
    
    static var member :MemberCodable!
    static var cart: OrderCodable!

    static func parseJson<T:Codable>(_ data: Data) -> T? {
        let decode = JSONDecoder()
        do {
            return try decode.decode(T.self, from: data)
        } catch  {
            print("JSON Data:" + String(data: data, encoding: .utf8)!)
            return nil
        }
    }
    static func getMember(){
        let url = URL(string: "\(NetWorkHandler.host)/getMember?member_id_phone=0900000000")!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            member = parseJson(data!)
            if member == nil{
//                fatalError("解析使用者失敗")
            }
        }
        task.resume()
    }
    
    static func getProduct(count: Int, _ completionHandler: @escaping ([ItemCodable], [UIImage?])->Void){
        let url = URL(string: "\(NetWorkHandler.host)/product?count=\(count)")!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let items = parseJson(data!) as [ItemCodable]? else{
                fatalError("解析產品資料失敗")
            }
            
            var images = [UIImage?](repeating: nil, count: count)
            for (index,item) in items.enumerated(){
                fetchImage(url: item.media_info) { image in
                    images[index] = image
                    for i in 0...index{
                        if images[i] == nil{
                            return
                        }
                    }
                    completionHandler(items, images)
                }
            }
            
        }
        task.resume()
    }
    
    static func getProduct(category: String, count: Int, _ completionHandler: @escaping ([ItemCodable], [UIImage?])->Void){
        let encodingStr = "\(NetWorkHandler.host)/product?count=\(count)&category=\(category)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodingStr!)!

        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let items = parseJson(data!) as [ItemCodable]? else{
                fatalError("解析產品資料失敗")
            }
            
            var images = [UIImage?](repeating: nil, count: count)
            for (index,item) in items.enumerated(){
                fetchImage(url: item.media_info) { image in
                    images[index] = image
                    for i in 0...index{
                        if images[i] == nil{
                            return
                        }
                    }
                    completionHandler(items, images)
                }
            }
            
        }
        task.resume()
    }
    
    static func fetchImage(url: URL, _ completionHandler: @escaping (UIImage)->Void ){

        let task = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            if let safeData = data{
                let image = UIImage(data: safeData) ?? UIImage(named: "sad")!
                completionHandler(image)
            }else{
                completionHandler(UIImage(named: "sad")!)
            }
        }
        task.resume()
    }
    
}
