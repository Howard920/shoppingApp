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

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Member.cellTitle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.textLabel?.text = Member.cellTitle[indexPath.row]
        return cell
    }
    

   // TableView delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let cellTiele = cell?.textLabel?.text
        
        switch cellTiele {
        //"訂單查詢",
        case "訂單查詢":
            print("訂單查詢")
        //"基本資料"
        case "基本資料":
            print("基本資料")
            performSegue(withIdentifier: "MemberInfo", sender: nil)
        //"修改密碼"
        case "修改密碼":
            print("修改密碼")
            performSegue(withIdentifier: "ResetPassword", sender: nil)
        //"買過的商品"
        case "買過的商品":
            print("買過的商品")
//            performSegue(withIdentifier: "ResetPassword", sender: nil)
        //"登出"
        case "登出":
            let alert = UIAlertController(title: "", message: "您確定要登出？", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print("OK, click")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("Cancel click")
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
}
