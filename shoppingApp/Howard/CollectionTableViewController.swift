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
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData(){
        
        let server_place:String = "\(NetWorkHandler.host)/searchItem?item_id=\(favoriteSystem.favoriteList.map{String($0)}.joined(separator: ","))"
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
                
                let searchResultData: [ProductInfo]? = NetWorkHandler.parseJson(keywordsSearchData)
               
                
                self.resultProductsInfo = searchResultData
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
            cell.item_id = item.item_id
            
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
//        -=-=-=-=-=-=-=-=-=-=-=- 價目表：原價與折扣 -=-=-=-=-=-=-=-=-=-=-=-
//        cell.PriceLabel.text = price[indexPath.row]
//        cell.DiscountLabel.text = discount[indexPath.row]
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let cell = tableView.cellForRow(at: indexPath) as! CollectionTableViewCell
            deleteItem(id: cell.item_id)
        }
    }
}


extension CollectionTableViewController: CellDelegate{
    
    func buyItem(id: Int) {
//        let row = favoriteSystem.favoriteList.firstIndex(of: id)!
        var item: ProductInfo!
        for product in resultProductsInfo!{
            if product.item_id == id{
                item = product
            }
        }
        
        
        cartSystem.updateCartProduct(product: OrderProduct(add_time: Date.get_add_time(), item_count: 1, item: ItemCodable(item_id: item.item_id, name: item.name, price: item.price, quantity: item.quantity!, detail: item.detail!, vendor_id: item.vendor_id!, media_info: URL(string: item.media_info!)!))) {
            error
            in
            self.deleteItem(id: id)
        }
    }
    
    func deleteItem(id: Int)
    {
        let row = favoriteSystem.favoriteList.firstIndex(of: id)!
        favoriteSystem.favoriteList.remove(at: row)
        loadData()
        DispatchQueue.main.async
        {
//            self.tableview.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        }
        
    }
}
