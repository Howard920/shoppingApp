import UIKit

class CollectionTableViewController: UITableViewController
{
    //產品項目
    var productName = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
//    var price = ["原價目表:price_Data"]
    var price = ["123", "513", "234", "123", "523", "312", "424", "75", "33", "14", "11", "12", "13", "14", "151", "616", "713", "819", "190", "200", "121"]

    
//    var discount = ["折扣價:discount_Data"]
    var discount = ["13", "14", "151", "616", "713", "819", "190", "200", "121","123", "513", "234", "123", "523", "312", "424", "75", "33", "14", "11", "12"]
    
    
    //產品圖片
    var productImage = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    
//    var productIsVisited = Array(repeating: false, count: 21)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        
        //計算目前產品個數
//        print(productName.count)
        return productName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!CollectionTableViewCell

        
        cell.nameLabel.text = productName[indexPath.row]
        cell.productImage.image = UIImage(named: productImage[indexPath.row])
            
//        -=-=-=-=-=-=-=-=-=-=-=- 價目表：原價與折扣 -=-=-=-=-=-=-=-=-=-=-=-
//        cell.PriceLabel.text = price[indexPath.row]
//        cell.DiscountLabel.text = discount[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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
            productName.remove(at: indexPath.row)
            productImage.remove(at: indexPath.row)
            price.remove(at: indexPath.row)
            discount.remove(at: indexPath.row)
//            被刪除的產品名稱 與上方的刪除狀態擇一使用
//            print("產品：\(productName.remove(at: indexPath.row))已被移除")
            print("目前產品個數:\(productName.count)")
            for name in productName
            {
                print(name)
            }
        }

        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        //更新資料異動後的畫面
        tableView.reloadData()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
