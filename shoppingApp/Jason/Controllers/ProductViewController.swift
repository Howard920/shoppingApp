//
//  ProductViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/18.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func myInit(){
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: -  TableView Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        return cell
    }
    
    
    // MARK: -  TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    
    
}
