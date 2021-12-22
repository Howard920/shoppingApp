//
//  SampleData.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/1.
//

import Foundation

struct SampleData {
    
    static let orderJson: Data =
            """
    [
      {
        "order_id": 4,
        "member_id_phone": "0900000000",
        "price": 1234,
        "shipment": "7-11取貨",
        "payment": "超商取貨付款",
        "order_date": "2021-11-11",
        "order_person_name": "Jason",
        "order_person_phone": "0908825252",
        "order_person_address": "Taipei101",
        "order_person_email": "jason@happshop.com.tw",
        "product_list": [
          {
            "item_count": 1,
            "item": {
              "item_id": 1,
              "name": "常香健枕頭",
              "price": 980,
              "quantity": 999,
              "detail": {
                "說明": "枕頭"
              },
              "vendor_id": 1,
              "media_info": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg"
            }
          },
          {
            "item_count": 10,
            "item": {
              "item_id": 3,
              "name": "常香健雙人床墊-弘道實業有限公司出品",
              "price": 3600,
              "quantity": 9999,
              "detail": {
                "說明": "床墊"
              },
              "vendor_id": 1,
              "media_info": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E5%BA%8A%E5%A2%8A/%E8%8C%B6%E8%91%89%E5%BA%8A%E5%A2%8A.jpg"
            }
          }
        ]
      }
    ]
    """.data(using: .utf8)!
    
    static let vendorJson: Data =
            """
        [
          {
            "vendor_id": 1,
            "name": "弘道實業有限公司",
            "address": "台北市德惠街173號五樓",
            "phone": 25961396,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E5%B8%B8%E9%A6%99%E5%81%A5logo/3.jpg",
            "contact": "劉振隆",
            "payment": "月結30天"
          },
          {
            "vendor_id": 2,
            "name": "常香健有限公司",
            "address": "台北市德惠街173號",
            "phone": 25961324,
            "logo": "https://github.com/scott93723/happy_shop_api/blob/main/%E5%B8%B8%E9%A6%99%E5%81%A5logo/43201722_2264559010456023_549238261738897408_n.jpg?raw=true",
            "contact": "劉天",
            "payment": "月結60天"
          },
          {
            "vendor_id": 3,
            "name": "台灣積體電路有限公司",
            "address": "高雄發大財一號",
            "phone": 7234567,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "劉德音",
            "payment": "月結60天"
          },
          {
            "vendor_id": 4,
            "name": "長榮航空公司",
            "address": "桃園機場路一號",
            "phone": 25963455,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "劉冰",
            "payment": "月結60天"
          },
          {
            "vendor_id": 5,
            "name": "中華航空公司",
            "address": "桃園機場路2號",
            "phone": 325962340,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "劉天仙",
            "payment": "月結60天"
          },
          {
            "vendor_id": 6,
            "name": "台灣三星電子分公司",
            "address": "桃園亞洲矽谷領航北路二段一號",
            "phone": 352362340,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "戴天",
            "payment": "月結60天"
          },
          {
            "vendor_id": 7,
            "name": "亞洲矽谷寶哥集團",
            "address": "桃園亞洲矽谷領航北路二段一號",
            "phone": 352362345,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "林雨璟",
            "payment": "月結60天"
          },
          {
            "vendor_id": 8,
            "name": "李愛花藝有限公司",
            "address": "桃園亞洲矽谷領航南路三段124號",
            "phone": 352362323,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "李明潔",
            "payment": "月結60天"
          },
          {
            "vendor_id": 9,
            "name": "林神經外科診所",
            "address": "桃園亞洲矽谷領航南路三段14號",
            "phone": 352362325,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "林葦婷",
            "payment": "月結60天"
          },
          {
            "vendor_id": 10,
            "name": "劉家生物科技有限公司",
            "address": "桃園亞洲矽谷領航南路三段234號",
            "phone": 352362312,
            "logo": "https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg",
            "contact": "劉秋萍",
            "payment": "月結60天"
          }
        ]
        """.data(using: .utf8)!
    
    static let memberJson: Data =
            """
        {
          "member_id_phone": "0900000000",
          "password": "111111111111",
          "name": "Mario",
          "gender": 1,
          "birthday": "1999-2-20",
          "address": "Japen",
          "like_list": "[333, 5555]"
        }
        """.data(using: .utf8)!
            
            
    static let productsJson: Data =
        """
[
  {
    "item_id": 2,
    "name": "百事可樂",
    "price": 286,
    "quantity": 888,
    "detail": {
        "容量":"100ml",
        "保存期限":"180天",
        "商品數量":"1箱 24入"
    },
    "vendor_id": 888,
    "media_info": "https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7446448/0/637731710733930000?v=1",
    "payment": [
      "7-11取貨",
      "全家取貨",
      "宅配"
    ],
    "delivery": [
      "超商貨到付款",
      "Apple Pay",
      "信用卡一次付清"
    ]},
  {
    "item_id": 1,
    "name": "可口可樂",
    "price": 25,
    "quantity": 999,
    "detail": {
        "容量":"330ml",
        "保存期限":"180天",
        "商品數量":"1入"
    },
    "vendor_id": 999,
    "media_info": "https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7446448/0/637731710733930000?v=1",
    "payment": [
      "7-11取貨",
      "全家取貨",
      "宅配"
    ],
    "delivery": [
      "超商貨到付款",
      "Apple Pay",
      "信用卡一次付清"
    ]
  },
  {
    "item_id": 11,
    "name": "【亞尼克】亞尼克生乳捲特黑，324g，共1入n",
    "price": 565,
    "quantity": 999,
    "detail": {
      "規格": "324G／18CM一條，共1條",
      "成份": "特黑－日本奶霜乳製品（牛奶）、食用植物油脂（棕櫚仁油、棕櫚油）、糊精、乳清蛋白、乳糖、乳化劑（脂肪酸甘油酯、大豆卵磷脂、脂肪酸蔗糖酯）、纖維素、乳清、香料、雞蛋、鮮奶、砂糖、日本麵粉、奶油、可可粉、蛋白粉"
    },
    "vendor_id": 1,
    "media_info": "https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7253814/0/637739494702870000?v=1",
    "payment": [
      "7-11取貨",
      "全家取貨",
      "宅配"
    ],
    "delivery": [
      "超商貨到付款",
      "Apple Pay",
      "信用卡一次付清"
    ]
  },
  {
    "item_id": 12,
    "name": "【晟品凍洋】極凍超厚切鮭魚，400g±10%/包*10包n",
    "price": 2750,
    "quantity": 999,
    "detail": {
      "規格": "400g±10％／包（10包)",
      "成份": "鮭魚"
    },
    "vendor_id": 1,
    "media_info": "https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7430949/0/637727440456630000?v=1",
    "payment": [
      "7-11取貨",
      "全家取貨",
      "宅配"
    ],
    "delivery": [
      "超商貨到付款",
      "Apple Pay",
      "信用卡一次付清"
    ]
  },
  {
    "item_id": 13,
    "name": "【Samsung】三星Galaxy智慧手錶，Watch4 BT 40mm R860",
    "price": 8990,
    "quantity": 999,
    "detail": {
      "型號": "R860（幻影黑、鈦灰銀、玫瑰金",
      "產地": "越南"
    },
    "vendor_id": 1,
    "media_info": "https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7446448/0/637731710733930000?v=1",
    "payment": [
      "7-11取貨",
      "全家取貨",
      "宅配"
    ],
    "delivery": [
      "超商貨到付款",
      "Apple Pay",
      "信用卡一次付清"
    ]
  }
]
""".data(using: .utf8)!
    
    static let popularJson: Data = """
    [
      {
        "name": "智慧",
        "count": 988990
      },
      {
        "name": "三星",
        "count": 970000
      },
      {
        "name": "Galaxy",
        "count": 888888
      },
      {
        "name": "極凍超厚切鮭魚",
        "count": 888888
      },
      {
        "name": "晟品凍洋",
        "count": 790534
      },
      {
        "name": "亞尼克",
        "count": 567856
      },
      {
        "name": "生乳捲",
        "count": 567856
      },
      {
        "name": "可樂",
        "count": 33333
      }
    ]
    """.data(using: .utf8)!
    
    static var products:[ProductInfo] = [
        ProductInfo(item_id: 100, name: "[光泉]保久乳_果汁牛乳200ml*24/箱, 超便宜, 買10箱再送一箱, 滿30箱再抽iPhone, 活動只到今天, 要買要快！！！", price: 399, quantity: Int.random(in: 1...9999), detail: ["容量":"100ml", "保存期限":"30天", "商品數量":"1箱 24入"], vendor_id: 999, media_info: nil, payment: ["Apple Pay", "Line Pay"], delivery: ["宅配", "超商取貨"]),
        ProductInfo(item_id: 101, name: "可樂", price: 25, quantity: Int.random(in: 1...9999), detail: ["容量":"330ml", "保存期限":"100天", "商品數量":"1入"], vendor_id: 999, media_info: nil, payment: ["Apple Pay", "Line Pay"], delivery: ["宅配", "超商取貨"]),
        ProductInfo(item_id: 102, name: "百事可樂", price: 286, quantity: Int.random(in: 1...9999), detail: ["容量":"100ml", "保存期限":"30天", "商品數量":"1箱 24入"], vendor_id: 999, media_info: nil, payment: ["Apple Pay", "Line Pay"], delivery: ["宅配", "超商取貨"]),
        ProductInfo(item_id: 103, name: "光泉低脂鮮乳1857ml到貨效期約6-8天", price: 163, quantity: Int.random(in: 1...9999), detail: ["容量":"1857ml", "保存期限":"14天",  "商品數量":"1入"], vendor_id: 999, media_info: nil, payment: ["Apple Pay", "Line Pay"], delivery: ["宅配", "超商取貨"]),
        ProductInfo(item_id: 104, name: "來一客-鮮蝦魚板-63g", price: 72, quantity: Int.random(in: 1...9999), detail: ["容量":"63g", "保存期限":"119天", "商品數量":"3入", "說明":"來自大海的清甜蝦仁，搭配小巧可愛的魚板，再佐以海帶嫩芽的鮮美湯頭，清爽風味獨樹一格。製造日期與有效期限，商品成分與適用注意事項皆標示於包裝或產品中, 本產品網頁因拍攝關係，圖檔略有差異，實際以廠商出貨為主, 本產品文案若有變動敬請參照實際商品為準"], vendor_id: 999, media_info: nil, payment: ["Apple Pay", "Line Pay"], delivery: ["宅配", "超商取貨"]),
        ProductInfo(item_id: 105, name: "五月花角落小夥伴衛生紙(FSC驗證)100PCx24", price: 339, quantity: Int.random(in: 1...9999), detail: ["容量":"100抽", "保存期限":"30天", "商品數量":"24入"], vendor_id: 999, media_info: nil, payment: ["Apple Pay", "Line Pay"], delivery: ["宅配", "超商取貨"]),
    ]
}

