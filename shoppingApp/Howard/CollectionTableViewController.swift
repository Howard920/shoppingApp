import UIKit

class CollectionTableViewController: UITableViewController
{
    var resultProductsInfo:[ProductInfo]?
    @IBOutlet var tableview: UITableView!
    
    
    
    
    @IBAction func btn_cancelProduct(_ sender: UIButton)
    {
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("下載...")

        // step1: prepare REQUEST
        let server_place:String = "http://api.shopshop.synology.me:5050/searchItem?item_id=\(favoriteSystem.favoriteList.map{String($0)}.joined(separator: ","))"
        print(favoriteSystem.favoriteList)
        
        
        let server_url:URL = URL(string: server_place)!
        let request:URLRequest = URLRequest(url: server_url)


        // step2: create Session
        let session:URLSession = URLSession.shared


        // step3: create the TASK that you want to do in the session
        var work:URLSessionDataTask
        work = session.dataTask(
        with: request,
        completionHandler:
            {
            (keywordsSearchData,response,error)
            in
            if let keywordsSearchData = keywordsSearchData {
                guard let searchResultData: [ProductInfo] = NetWorkHandler.parseJson(keywordsSearchData)
                else{
                    return
                }
                
                self.resultProductsInfo = searchResultData
                print(self.resultProductsInfo!)
                DispatchQueue.main.async
                {
                    self.tableview.reloadData()
                }
            }
            print("I finish request to server")
            
        }
        )
        // step4: executive the TASK
        
        work.resume()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        resultProductsInfo?.count ?? 0

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CollectionTableViewCell

        if let item:ProductInfo = resultProductsInfo?[indexPath.row]
        {
            cell.nameLabel.text = item.name
            cell.PriceLabel.text = String(item.price)
            
            DatabaseHandler.fetchImage(url: URL(string: item.media_info!)!) {
                image
                in
                DispatchQueue.main.async
                {
                    cell.productImage.image = image
                }
            }
            
            
        }
          
        cell.delegate = self
        cell.row = indexPath.row
//        -=-=-=-=-=-=-=-=-=-=-=- 價目表：原價與折扣 -=-=-=-=-=-=-=-=-=-=-=-
//        cell.PriceLabel.text = price[indexPath.row]
//        cell.DiscountLabel.text = discount[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
     {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            productName.remove(at: indexPath.row)
//            productImage.remove(at: indexPath.row)
//            price.remove(at: indexPath.row)
//            discount.remove(at: indexPath.row)
////            被刪除的產品名稱 與上方的刪除狀態擇一使用
////            print("產品：\(productName.remove(at: indexPath.row))已被移除")
//            print("目前產品個數:\(productName.count)")
//            for name in productName
//            {
//                print(name)
//            }
        }

        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        //更新資料異動後的畫面
        tableView.reloadData()
    }
}


extension CollectionTableViewController: cellDelegate{
    
    func buyItem(row: Int) {
        
        let item = resultProductsInfo![row]
        
        cartSystem.updateCartProduct(product: OrderProduct(item_count: 1, item: ItemCodable(item_id: item.item_id, name: item.name, price: item.price, quantity: item.quantity!, detail: item.detail!, vendor_id: item.vendor_id!, media_info: URL(string: item.media_info!)!))) {
            error
            in
            self.deleteItem(row: row)
        }
    }
    
    func deleteItem(row: Int)
    {
        
        resultProductsInfo?.remove(at: row)
        DispatchQueue.main.async
        {
            self.tableview.reloadData()
        }
        
    }
}
