//
//  APIManeger.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/8.
//

import Foundation
import UIKit

class DatabaseHandler{
    
    static func parseJson<T:Codable>(_ data: Data) -> T? {
        let decode = JSONDecoder()
        do {
            return try decode.decode(T.self, from: data)
        } catch  {
            print("JSON Data:" + String(data: data, encoding: .utf8)!)
            return nil
        }
    }
    
    static func getProduct(count: Int, _ completionHandler: @escaping ([ItemCodable])->Void){
        let url = URL(string: "http://127.0.0.1:8080/product?count=\(count)")!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let items = parseJson(data!) as [ItemCodable]? else{
                fatalError("解析產品資料失敗")
            }
            completionHandler(items)
            
        }
        task.resume()
    }
    
    static func getProduct(category: String, count: Int, _ completionHandler: @escaping ([ItemCodable])->Void){
        let encodingStr = "http://127.0.0.1:8080/product?count=\(count)&category=\(category)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodingStr!)!

        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let items = parseJson(data!) as [ItemCodable]? else{
                fatalError("解析產品資料失敗")
            }
            completionHandler(items)
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
