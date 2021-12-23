//
//  LinkBrain.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/12/18.
//

import UIKit

struct Cooperative{
    static func goProductVC(rootVC: UIViewController?, item: ItemCodable){
        if let productVC = UIStoryboard(name: "Search", bundle:     nil).instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            // 設定為全螢幕模式
            productVC.modalPresentationStyle = .fullScreen
            // 開啟商品畫面
            let product = ProductInfo(
                item_id: item.item_id,
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                detail: item.detail,
                vendor_id: item.vendor_id,
                media_info: item.media_info.absoluteString,
                payment: nil,
                delivery: nil
            )
            productVC.selectedProduct = product
//            rootVC?.present(productVC, animated: true, completion: nil)
            rootVC?.navigationController?.pushViewController(productVC, animated: true)
        }

    }
    
    static func goProductVC(rootVC: UIViewController?, product: ProductInfo){
        if let productVC = UIStoryboard(name: "Search", bundle:     nil).instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            // 設定為全螢幕模式
            productVC.modalPresentationStyle = .fullScreen
            // 開啟商品畫面
//            let product = ProductInfo(
//                item_id: item.item_id,
//                name: item.name,
//                price: item.price,
//                quantity: item.quantity,
//                detail: item.detail,
//                vendor_id: item.vendor_id,
//                media_info: item.media_info.absoluteString,
//                payment: nil,
//                delivery: nil
//            )
            productVC.selectedProduct = product
//            rootVC?.present(productVC, animated: true, completion: nil)
            rootVC?.navigationController?.pushViewController(productVC, animated: true)
        }

    }
}
