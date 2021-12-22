//
//  FavoriteSystem.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/20.
//

import Foundation

let favoriteSystem = FavoriteSystem()

enum myError: Error{
    case parseError
    case nilData
    case noMember
}

class FavoriteSystem{
   
    let userDefault = UserDefaults.standard
    var favoriteList = [Int](){
        didSet{
//            userDefault.setValue(favoriteList, forKey: "favoriteList")
            print(favoriteList)
            updateFavoiteList { error in
                if error == nil{
                    self.getFavoriteList { error in
                        print("online: \(self.favoriteList)")
                    }
                }
            }
        }
    }
    
    
    func getFavoriteList(completionHandler: @escaping (Error?)->Void){
        let url = URL(string: "\(NetWorkHandler.host)/getMember?member_id_phone=\(UserInfo.member_id_phone)")!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [unowned self] data, response, error in

            guard let member = DatabaseHandler.parseJson(data!) as Member? else{
                completionHandler(myError.parseError)
                return
            }
            if member.like_list == nil{
                self.favoriteList = []
            }else{
                if self.favoriteList != member.like_list!{
                    self.favoriteList = member.like_list!
                }
            }
            
            completionHandler(nil)
        }
        task.resume()
    }
    
    func updateFavoiteList(completionHandler: @escaping (Error?)->Void){
        
        var likeListStr = "\(favoriteList)"
        likeListStr = likeListStr.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        let url = URL(string: "\(NetWorkHandler.host)/updateFavorite?member_id_phone=\(UserInfo.member_id_phone)&like_list=\(likeListStr)")!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let safeData = data else{
                completionHandler(myError.nilData)
                return
            }
            if String(data: safeData, encoding: .utf8) == "收藏列表更新成功"{
                completionHandler(nil)
            }else{
                completionHandler(myError.noMember)
            }
        }
        task.resume()
    }

}
