//
//  LoginRegisterViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/7.
//

import UIKit

class LoginRegisterViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var commitButton: UIButton!
    
    weak var memberTableView:UITableView!
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if UserInfo.isLogin{
            memberTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.tag = 10
        passwordTextField.tag = 11
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        
        commitButton.layer.cornerRadius = 10
        commitButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    @IBAction func resetPassword(_ sender: UIButton) {
    }
    
    @IBAction func commitClick(_ sender: UIButton) {
        let memberID = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if memberID.count != 10 {
            Common.autoDisapperAlert(self, message: "手機必需10碼", duration: 1)
        } else if password.count < 8 {
            Common.autoDisapperAlert(self, message: "密碼必需8~12碼", duration: 1)
            
        }else {
            registerMember(phoneNumber: memberID, password: password)
        }
    }
    
    private func registerMember(phoneNumber: String,  password: String){
        let path = "/addMember"
        let parameter = "?member_id_phone=\(phoneNumber)&password=\(password)"
        
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
                case "註冊成功", "登入成功":
                    DispatchQueue.main.async {
                        //                    UserInfo.isLogin = true
                        // 使用者帳號寫入離線資料
                        UserInfo.member_id_phone = self.phoneTextField.text!
                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                default:
                    DispatchQueue.main.async {
                        Common.autoDisapperAlert(self, message: msg, duration: 1)
                    }
                }
            }
            
        }.resume()
    }
    
    
}

extension LoginRegisterViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 10{
            let currentText = textField.text! + string
            return currentText.count <= 10
        }
        else {
            let currentText = textField.text! + string
            return currentText.count <= 12
        }
    }
}
