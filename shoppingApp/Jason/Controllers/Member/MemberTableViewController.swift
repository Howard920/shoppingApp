//
//  MemberTableViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/23.
//

import UIKit

class MemberTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 去除空白cell
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

    }
    override func viewWillAppear(_ animated: Bool) {
        UserInfo.isLogin =  UserInfo.member_id_phone.isEmpty ? false : true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemberPage.cellTitle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        let cellTitle = MemberPage.cellTitle[indexPath.row]
        cell.textLabel?.text = cellTitle
        if UserInfo.isLogin {
            cell.textLabel?.textColor = .black
            cell.selectionStyle = .default
        } else {
            cell.textLabel?.textColor = .systemGray
            cell.selectionStyle = .none
        }
        
        switch cellTitle {
        case "登出":
            cell.textLabel?.textColor = .black
            cell.textLabel?.text =  UserInfo.isLogin ? "登出" : "登入/註冊"

        default:
            break
        }
               
        return cell
    }
    

   // TableView delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let cellTiele = cell?.textLabel?.text
        
        if UserInfo.isLogin {
            switch cellTiele {
            //"訂單查詢",
            case "訂單查詢":
                performSegue(withIdentifier: "BuyListCollectionViewController", sender: nil)
            //"基本資料"
            case "基本資料":
                performSegue(withIdentifier: "MemberInfo", sender: nil)
            //"修改密碼"
            case "修改密碼":
                performSegue(withIdentifier: "ResetPasswordViewController", sender: nil)
            //"買過的商品"
            case "買過的商品":
                performSegue(withIdentifier: "BuyItemsListViewController", sender: nil)

            //"登出"
            case "登出":
                if UserInfo.isLogin {
                    let alert = UIAlertController(title: "", message: "您確定要登出？", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        // 清空member內容
                        Common.member = nil
                        UserInfo.member_id_phone = ""
                        tableView.reloadData()
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                
                }
               
            default:
                break
            }
        } else {
            if cellTiele == "登入/註冊" {
                performSegue(withIdentifier: "LoginRegisterViewController", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LoginRegisterViewController{
            
            vc.memberTableView = tableView
        }
    }
}
