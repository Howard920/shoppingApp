//
//  SearchTableViewController.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/9.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInit()
//        Keywords.historyWords = []
        
    }

    private func loadInit(){
        // MARK: -  Nib Register
        tableView.register(UINib(nibName: "\(PopularKeywordsTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(PopularKeywordsTableViewCell.self)")
        
        // MARK: -  Setting SearchController
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "搜尋..."
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 如果歷史搜尋記錄有內容就回傳2, 反之回傳1
        guard Keywords.historyWords.isEmpty else {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         依Keywords.historyIsHidden狀態決定是否要計算history的cell數量, 預設section0＝歷史記錄, section1=熱門關鍵字
         如果Keywords.historyIsHidden=true, section 0 = 熱門關鍵字
         */
        guard !Keywords.historyWords.isEmpty else {return 1}
        return section == 0 ? Keywords.historyWords.count + 1 : 1
       
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if Keywords.historyWords.isEmpty {
            return Keywords.popularHeaderText
        } else {
            return section == 0 ? Keywords.historyHeaderText : Keywords.popularHeaderText
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Keywords.historyWords.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularKeywordsTableViewCell.self)", for: indexPath) as! PopularKeywordsTableViewCell
            cell.delegate = self
            cell.configure(with: Keywords.populayWords)
            return cell
            
        } else {
            if indexPath.section == 0 {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "historycell")
                if indexPath.row == Keywords.historyWords.count {
                    cell.textLabel?.text = Keywords.clearHistoryText
                } else {
                    cell.textLabel?.text = Keywords.historyWords[indexPath.row]
                    cell.imageView?.image = UIImage(systemName: "clock.arrow.circlepath")
                }
                return cell
                
            } else {
               
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularKeywordsTableViewCell.self)", for: indexPath) as! PopularKeywordsTableViewCell
                // cell的delegate綁定, 熱門關鍵字按鈕點擊才會有反應
                cell.delegate = self
                cell.configure(with: Keywords.populayWords)
                return cell
            }
        }
    }
    
    // MARK: -  Cell select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 如果有歷史搜尋記錄才會做
        if !Keywords.historyWords.isEmpty {
            // 取得"清除歷史記錄"cell的indexPath"
            let myIndex = IndexPath(row: Keywords.historyWords.count, section: 0)
            // 是否點擊清除歷史記錄Cell
            if indexPath == myIndex{
                // 將歷史記錄清除
                Keywords.historyWords = []
                // 更新tabviewUI
                tableView.reloadData()
            } else {
                // 取得點選的Cell
                let cell = tableView.cellForRow(at: indexPath)
                // 沒拿到歷史記錄Cell的搜尋關鍵字, 就離開這個function
                guard let myTitle =  cell?.textLabel?.text else { return }
                // 開始搜尋結果, 把搜尋關鍵字傳到下一頁
                performSegue(withIdentifier: Keywords.segueIdOfSearchResult, sender: myTitle)
            }
           
        }
    }
    // MARK: -  prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! ResultCollectionViewController
        guard let myTitle = sender as? String else {return}
        detailVC.title = "搜尋： \(myTitle)"
    }
}
// MARK: -  extension

extension SearchTableViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        // searchBar 點選 或 文字內容變更時會call
    }
    
    // Cancel按鈕事件
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 去除空白, 換行字元
        let keyword = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // 確認SearchBar有輸入關鍵字
        guard keyword.count > 0 else { return }
        // 開啟搜尋結果頁面
        performSegue(withIdentifier: Keywords.segueIdOfSearchResult, sender: keyword)
        // 判斷歷史記錄沒有這次搜尋的關鍵字, 才會把關鍵字加入歷史記錄, 然後更新tableviewUI
        guard !Keywords.historyWords.contains(keyword) else { return }
        Keywords.historyWords.append(keyword)
        tableView.reloadData()
    }
}
// MARK: -  PopularKeywordsTableViewCellDelegate

extension SearchTableViewController: PopularKeywordsTableViewCellDelegate{
    func didTapButton(with title: String) {
//        print(title)
        performSegue(withIdentifier: Keywords.segueIdOfSearchResult, sender: title)
    }
}
