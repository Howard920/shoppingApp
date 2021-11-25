//
//  Cart3ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

import UIKit

class Cart3ViewController: UIViewController {

    @IBOutlet weak var lb_order_summary: UILabel!
   
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cartStepView: CartStepView!
    @IBOutlet var stackViews: [UIStackView]!
    @IBOutlet var rows: [UIView]!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setDefaultValue()
        addKeyboardNotification()
    }

    func setDefaultValue(){
        var numberOfItems = 0
        for item in orderSiang.orderItems{
            numberOfItems += item.num
        }
        lb_order_summary.text = "共\(numberOfItems)項商品，總計 NT$\(orderSiang.price.value)"
    }
    
    func setLayout(){
        
        cartStepView.stepLabels[2].textColor = UIColor.red
        cartStepView.stepBars[2].backgroundColor = UIColor.red
        stackViews[0].layer.borderWidth = 0.5
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.cornerRadius = 5
        emailTextField.clipsToBounds = true
        stackViews[0].layer.borderColor = UIColor.lightGray.cgColor
        stackViews[0].layer.cornerRadius = 5
        stackViews[0].clipsToBounds = true
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: rows[0].frame.height - 0.5, width: rows[0].frame.width, height: 0.5)
        bottomLine1.backgroundColor = UIColor.lightGray.cgColor
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: rows[0].frame.height - 0.5, width: rows[0].frame.width, height: 0.5)
        bottomLine2.backgroundColor = UIColor.lightGray.cgColor
        rows[0].layer.addSublayer(bottomLine1)
        rows[1].layer.addSublayer(bottomLine2)
        sendButton.layer.cornerRadius = 5
        sendButton.clipsToBounds = true
    }
    
    
    func addKeyboardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillbeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc func keyboardWillbeHidden(){
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @IBAction func tapScrollView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func sendBurronPressed(_ sender: UIButton) {
        
        orderSiang.customer.name = textFields[0].text
        orderSiang.customer.phone = textFields[1].text
        orderSiang.customer.address = textFields[2].text
        orderSiang.customer.email = textFields[3].text
        
        if orderSiang.customer.name != "",
           orderSiang.customer.phone != "",
           orderSiang.customer.address != ""{
            view.endEditing(true)
            print("YES")
            print(orderSiang)
        }
    }
}
  
 
