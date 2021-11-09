//
//  SearchResultTableViewController.swift
//  HappyShop
//
//  Created by jason on 2021/10/21.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Products.testData.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as? SearchResultTableViewCell else {return SearchResultTableViewCell()}
       
        cell.nameLabel.text = Products.testData[indexPath.row].name
        cell.priceLabel.text = " $ " + Products.testData[indexPath.row].price.description
        if let imgName = Products.testData[indexPath.row].picture{
            cell.pictureImageView.image = UIImage(named: imgName)
        }
        return cell
    }
    
}

extension SearchResultTableViewController: UISearchBarDelegate{
    
    
}
