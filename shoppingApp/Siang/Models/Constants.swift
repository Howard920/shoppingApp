//
//  WelcomeViewModel.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/27.
//

import UIKit

struct Constants{
    static let categories = [Category(title: "防疫商品", image: UIImage(named: "防疫商品")!),
                      Category(title: "冷凍店取", image: UIImage(named: "冷凍店取")!),
                      Category(title: "箱購飲料", image: UIImage(named: "箱購飲料")!),
                      Category(title: "甜點蛋糕", image: UIImage(named: "甜點蛋糕")!),
                      Category(title: "素食蔬食", image: UIImage(named: "素食蔬食")!),
                      Category(title: "水產海鮮", image: UIImage(named: "水產海鮮")!),
                      Category(title: "生鮮肉品", image: UIImage(named: "生鮮肉品")!),
                      Category(title: "3C週邊", image: UIImage(named: "3C週邊")!),
                      Category(title: "生活日用", image: UIImage(named: "生活日用")!),
                      Category(title: "餅乾零食", image: UIImage(named: "餅乾零食")!),
                      Category(title: "熟食小吃", image: UIImage(named: "熟食小吃")!),
                      Category(title: "保健食品", image: UIImage(named: "保健食品")!),
                      Category(title: "毛小孩", image: UIImage(named: "毛小孩")!),
                      Category(title: "家具廚具", image: UIImage(named: "家具廚具")!),
                      Category(title: "美妝用品", image: UIImage(named: "美妝用品")!),
                      Category(title: "首飾配件", image: UIImage(named: "首飾配件")!),
                      Category(title: "服飾", image: UIImage(named: "服飾")!),
                      Category(title: "包包提袋", image: UIImage(named: "包包提袋")!),
                      Category(title: "文創商品", image: UIImage(named: "文創商品")!),
                      Category(title: "文/玩具", image: UIImage(named: "文玩具")!),
    ]
}

struct Category {
    var title: String
    var image: UIImage
}
