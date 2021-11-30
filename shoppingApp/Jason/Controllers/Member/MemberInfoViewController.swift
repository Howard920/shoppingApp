//
//  MemberInfoViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/25.
//

import UIKit

class MemberInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MemberInfo", bundle: nil), forCellReuseIdentifier: "MemberInfo")
    }
    @IBAction func confirmClick(_ sender: UIButton) {
        print("confirm")
        self.dismiss(animated: true, completion: nil)
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
        Member.cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberInfo", for: indexPath) as! MemberInfo
        cell.titleLabel.text = Member.InfoTitle[indexPath.row]
        cell.infoTextField.placeholder = "請在此輸入\(Member.InfoTitle[indexPath.row])"
        // 設定editingDidBegin的事件
        cell.infoTextField.addTarget(self, action: #selector(beginEdit), for: .editingDidBegin)
        // 設定editingDidEnd的事件
        cell.infoTextField.addTarget(self, action: #selector(endEdit(_:)), for: .editingDidEnd)
        // 設定editingDidEndOnExit的事件
        cell.infoTextField.addTarget(self, action: #selector(endOnExit(_:)), for: .editingDidEndOnExit)
        
        cell.infoTextField.tag = indexPath.row
        cell.underlineView.tag = indexPath.row
        return cell
    }
    
    
    // delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
