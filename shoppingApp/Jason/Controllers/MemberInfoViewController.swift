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
    
}

extension MemberInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Member.cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberInfo", for: indexPath) as! MemberInfo
        cell.titleLabel.text = Member.InfoTitle[indexPath.row]
        return cell
    }
}
