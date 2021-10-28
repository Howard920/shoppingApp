//
//  WelcomeViewModel.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/27.
//

import UIKit

class WelcomeViewModel {
    var colorOfViews = [ColorElement(indexOfAllColor: 4), ColorElement(indexOfAllColor: 0), ColorElement(indexOfAllColor: 1)]
    var numOfAllColor = 5
    
    var categories = [Category(title: "防疫商品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "冷凍店取", image: UIImage(named: "Candles-icon")!),
                      Category(title: "箱購飲料", image: UIImage(named: "Candles-icon")!),
                      Category(title: "甜點蛋糕", image: UIImage(named: "Candles-icon")!),
                      Category(title: "素食蔬食", image: UIImage(named: "Candles-icon")!),
                      Category(title: "水產海鮮", image: UIImage(named: "Candles-icon")!),
                      Category(title: "生鮮肉品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "3C週邊", image: UIImage(named: "Candles-icon")!),
                      Category(title: "生活日用", image: UIImage(named: "Candles-icon")!),
                      Category(title: "餅乾零食", image: UIImage(named: "Candles-icon")!),
                      Category(title: "熟食小吃", image: UIImage(named: "Candles-icon")!),
                      Category(title: "保健商品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "毛小孩", image: UIImage(named: "Candles-icon")!),
                      Category(title: "家具廚具", image: UIImage(named: "Candles-icon")!),
                      Category(title: "美妝用品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "首飾配件", image: UIImage(named: "Candles-icon")!),
                      Category(title: "服飾", image: UIImage(named: "Candles-icon")!),
                      Category(title: "包包提袋", image: UIImage(named: "Candles-icon")!),
                      Category(title: "文創商品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "文/玩具", image: UIImage(named: "Candles-icon")!),
    ]
    
    func lastImage(){
        for viewIndex in 0...2{
            colorOfViews[viewIndex].indexOfAllColor -= 1
            
            if colorOfViews[viewIndex].indexOfAllColor < 0{
                colorOfViews[viewIndex].indexOfAllColor = numOfAllColor - 1
            }
            
        }
    }
    
    func nextImage(){
        for viewIndex in 0...2{
            colorOfViews[viewIndex].indexOfAllColor += 1
            
            if  colorOfViews[viewIndex].indexOfAllColor > numOfAllColor - 1{
                colorOfViews[viewIndex].indexOfAllColor = 0
            }
        }
    }
}
