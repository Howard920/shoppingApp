//
//  MemberInfoViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/25.
//

import UIKit

class MemberInfoViewController: UIViewController {
    var name = ""
    var birthday = ""
    var gender = 0
    var address = ""
    var member: Member?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MemberInfo", bundle: nil), forCellReuseIdentifier: "MemberInfo")
       
        guard let member = Common.member else {
        return
        }
        self.member = member
    }
    
    @IBAction func confirmClick(_ sender: UIButton) {
        
        for num in 1...MemberPage.InfoTitle.count-1{
            let indexPath = IndexPath(row: num, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! MemberInfo
            switch num {
            case 1:
                name =  cell.infoTextField.text!
            case 2:
                birthday =  cell.infoTextField.text!
            case 3:
                gender =  cell.infoTextField.text! == "女" ? 0 : 1
            case 4:
                address =  cell.infoTextField.text!
            default:
                break
            }
        }
        
        let path = "/updateMember"
        let parameter = "?member_id_phone=\(UserInfo.member_id_phone)&name=\(name)&gender=\(gender)&birthday=\(birthday)&address=\(address)"
        let registerUrlString =  NetWorkHandler.host + path + parameter
        
        guard let url = URL(string: registerUrlString) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {  (updateMemberResponseData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let updateMemberResponseData = updateMemberResponseData {
                let msg = String(data: updateMemberResponseData, encoding: .utf8)!
                guard msg == "個人資料修改成功" else {
                    DispatchQueue.main.async {
                        Common.autoDisapperAlert(self, message: msg, duration: 1)
                    }
                    return
                    
                }
                // 更新member
                Common.member?.name = self.name
                Common.member?.gender = self.gender
                Common.member?.birthday = self.birthday
                Common.member?.address = self.address

                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            
        }.resume()
    }
    
    //editingDidBegin要做的內容
    @objc private func beginEdit(_ sender: UITextField){
        let row = sender.tag
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! MemberInfo
        cell.underlineView.backgroundColor = .orange
    }
    
    //editingDidEnd要做的內容
    @objc private func endEdit(_ sender: UITextField){
        let row = sender.tag
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! MemberInfo
        cell.underlineView.backgroundColor = .clear
        
    }    
    //endOnExit要做的內容
    @objc private func endOnExit(_ sender: UITextField){
    }
    
}



extension MemberInfoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MemberPage.cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberInfo", for: indexPath) as! MemberInfo
        cell.titleLabel.text = MemberPage.InfoTitle[indexPath.row]

        cell.infoTextField.placeholder = "請在此輸入\(MemberPage.InfoTitle[indexPath.row])"
        // 設定editingDidBegin的事件
        cell.infoTextField.addTarget(self, action: #selector(beginEdit), for: .editingDidBegin)
        // 設定editingDidEnd的事件
        cell.infoTextField.addTarget(self, action: #selector(endEdit(_:)), for: .editingDidEnd)
        // 設定editingDidEndOnExit的事件
        cell.infoTextField.addTarget(self, action: #selector(endOnExit(_:)), for: .editingDidEndOnExit)
        
        cell.infoTextField.tag = indexPath.row
        cell.underlineView.tag = indexPath.row
        
        switch indexPath.row {
        case 0:
            cell.infoTextField.isEnabled = false
            cell.infoTextField.backgroundColor = .systemGray2
            cell.infoTextField.text = UserInfo.member_id_phone
        case 1:
            cell.infoTextField.text = member?.name ?? ""
        case 2:
            cell.infoTextField.text = member?.birthday ?? ""
        case 3:
            cell.infoTextField.text = (member?.gender == 0 ? "女" : "男") ?? ""
        case 4:
            cell.infoTextField.text = member?.address ?? ""
        default:
            break
        }
        
        return cell
    }
    
    
    // delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
