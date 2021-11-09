//
//  SearchTableViewController.swift
//  HappyShop
//
//  Created by Jason Deng on 2021/10/27.
//

import UIKit

class SearchTableViewController: UITableViewController {
    var members = ["Jack", "Berry", "Eva", "Jack1", "Berry1", "Eva1", "Jack2", "Berry2", "Eva2", "Jack3", "Berry3", "Eva3", "Jack4", "Berry4", "Eva4"]
    var searchController: UISearchController?
    var searchResults: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController){
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
        
    }
    
    
    func filterContent(for searchText: String){
        searchResults = members.filter({ (member) -> Bool in
            let isMatch = member.localizedCaseInsensitiveContains(searchText)
            print("isMatch: \(isMatch)", member)
            return true
        })
        
    }
    
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") else {return UITableViewCell()}
        
        cell.textLabel?.text = members[indexPath.row]
        
        return cell
    }

}
