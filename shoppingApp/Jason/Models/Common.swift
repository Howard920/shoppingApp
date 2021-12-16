//
//  Calculator.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/6.
//

import Foundation
import UIKit

class Common {
    
    
    // 利用String類別的bonudingRect方法來取得文字的高度, 寬度
    static func getStringSize(withText text: String, width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect: CGSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox: CGSize = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        return boundingBox
    }
    
    static func autoDisapperAlert(_ controller: UIViewController, message: String = "已收藏", duration: Double = 1){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { [weak controller] in
                guard controller?.presentedViewController == alert else { return }
                
                controller?.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}
