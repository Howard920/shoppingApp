//
//  ResetPasswordViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/12.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        newPassword.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetButtonDidTap(_ sender: UIButton){
        var msg = ""
        if password.text!.count < 8 {
            msg = "舊密碼必需8~12碼"
        }else if newPassword.text!.count < 8{
            msg = "新密碼必需8~12碼"
        } else {
            resetPassword()
            return
        }
        
        Common.autoDisapperAlert(self, message: msg, duration: 1)
    }
    
    @IBAction func forgetDidTap(_ sender: UIButton){
        print(sender.currentTitle)
    }
    
    private func resetPassword(){
        let path = "/resetPassword"
        let parameter = "?member_id_phone=\(UserInfo.member_id_phone)&newPassword=\(newPassword.text!)&password=\(password.text!)"
        let apiURL =  NetWorkHandler.host + path + parameter
        guard let url = URL(string: apiURL) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {  (registerData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let registerData = registerData {
                let msg = String(data: registerData, encoding: .utf8)!
                
                switch msg {
                case "無此帳號", "密碼錯誤":
                    DispatchQueue.main.async {
                        Common.autoDisapperAlert(self, message: msg, duration: 1)
                    }
                default:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }.resume()
        
    }
    
}

extension ResetPasswordViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text! + string
        return currentText.count <= 12
    }
}
