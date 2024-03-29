//
//  ProductViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/18.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var productPictureImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productIsLikeButton: UIButton!
    
    var selectedProduct:ProductInfo?
    var productImage: UIImage?
    var categoryTags: CategoryTags?
    var popularItems: [ProductInfo]?
        
    deinit {
        print("ProductViewController deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide tab bar
        self.tabBarController?.tabBar.isHidden = true
        fetchDataFromServer()
        updateCartLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // show tab bar
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        if navigationController!.viewControllers.count >= 2, let vc = navigationController!.viewControllers[1] as? ResultCollectionViewController {
            vc.collectionView.reloadData()
        }
        
    }
    
    private func myInit(){        
        // set tabview delegate
        tableView.delegate = self
        tableView.dataSource = self
        // set Button tag
        addToCartButton.tag = 0
        checkOutButton.tag = 1
        cartButton.tag = 2
        productIsLikeButton.tag = 3
        shareButton.tag = 4
        
        // register cell
        tableView.register(ProductTableViewCell.nib(), forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(EmbedCollectionViewTableViewCell.nib(), forCellReuseIdentifier: EmbedCollectionViewTableViewCell.identifier)
        tableView.register(ProductItemInfoTableViewCell.nib(), forCellReuseIdentifier: ProductItemInfoTableViewCell.identifier)
        
        tableView.register(EmbedProductInTableViewCell.nib(), forCellReuseIdentifier: EmbedProductInTableViewCell.identifier)
        
        // 設定 加入購物車 按鈕的邊框, 邊框顏色, 圓角, 是否開啟圓角
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.clipsToBounds = true
        // 設定 立即結帳 按鈕的邊框, 邊框顏色, 圓角, 是否開啟圓角
        checkOutButton.layer.cornerRadius = 15
        checkOutButton.clipsToBounds = true
        // cart button
        cartButton.addSubview(badgeLabel())
        
        // 商品相關UI設定
        guard let name = selectedProduct?.name,
              let price = selectedProduct?.price.description,
              let quantity = selectedProduct?.quantity?.description        
        else { return }
        productTitleLabel.text = name
        productPriceLabel.text = "$ " + price
        productQuantity.text = "數量：\(quantity)"
        productPictureImageView.image = nil
        // set image
        if let urlStr = selectedProduct?.media_info,
           let url = URL(string: urlStr)  {
            let imageURL = url
            let imageLoader = ImageLoader()
            
            imageLoader.loadImage(at: imageURL) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.productPictureImageView.image = image
                    }
                case .failure(.invalidData):
                    Common.autoDisapperAlert(self, message: "資料傳輸失敗", duration: 1)
                    
                case .failure(.networkFailure(let error)):
                    Common.autoDisapperAlert(self, message: "網路異常\(error)", duration: 1)
                }
            }
        }
        
        // MARK: -  Button Setting
        // favorite
        if UserInfo.favoriteList.contains(selectedProduct!.item_id){
            productIsLikeButton.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            productIsLikeButton.imageView?.image = UIImage(systemName: "heart")
        }
    }
    // MARK: -  Update Cart Lable
    private func updateCartLabel(){
        let label = view.viewWithTag(999) as! UILabel
        label.text = cartSystem.cart.product_list.count.description
    }
    
    // MARK: -  show CartViewController
    private func showCartViewController(){
        // 取得Cart1ViewController實體
        if let cartVC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "Cart") as? UINavigationController {
            // 設定為全螢幕模式
            cartVC.modalPresentationStyle = .fullScreen
            // 開啟購物車畫面
            present(cartVC, animated: true, completion: nil)
        }
    }
    
    
    // 購物車右上角的小數字
    private func badgeLabel() -> UIView{
        let badgeCount = UILabel(frame: CGRect(x: 33, y: -12, width: 20, height: 20))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 2
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .red
        badgeCount.tag = 999
        badgeCount.text = cartSystem.cart.product_list.count.description
        return badgeCount
    }
    
    // MARK: -  Button Event
    @IBAction func didTapButton(_ sender: UIButton) {
        print(sender.tag)
        // 取得商品編號
        let itemId = selectedProduct!.item_id
        // 以button的tag號碼區別誰被按下
        switch sender.tag {
        case 0: // 0=addToCart
            if !UserInfo.cartList.contains(itemId){
                UserInfo.cartList.append(itemId)
                // 將商品傳送至購物車頁
                Common.autoDisapperAlert(self, message: Common.cart)
//                Common.addItemToCart(selectedProduct!)
                let item: ItemCodable = ItemCodable.init(
                    item_id: selectedProduct!.item_id,
                    name: selectedProduct!.name,
                    price: selectedProduct!.price,
                    quantity: selectedProduct!.quantity ?? 0,
                    detail: selectedProduct!.detail ?? [:],
                    vendor_id: selectedProduct!.vendor_id ?? 0,
                    media_info: URL(string:selectedProduct!.media_info ?? "")!)
                let orderProduct = OrderProduct(add_time: Date.get_add_time(), item_count: 1, item: item)
                cartSystem.updateCartProduct(product: orderProduct) { (_) in
                    // 更新購物車數字/////
                    DispatchQueue.main.async {
                        self.updateCartLabel()

                    }
                }
                
            } else {
                Common.autoDisapperAlert(self, message: Common.cart)
            }
            // 更新購物車數字
            updateCartLabel()
           
           
        case 1: //checkOutButton button
            if !UserInfo.cartList.contains(itemId){
                UserInfo.cartList.append(itemId)
                // 將商品傳送至購物車頁
                Common.addItemToCart(selectedProduct!)
                // 更新購物車數字
                updateCartLabel()
            }
            // checkOutButton button
            showCartViewController()
            
        case 2: // cart button
            showCartViewController()
            
        case 3: // favorite
            // 如果收藏清單內沒有收藏這個商品，就加入清單。
            if !UserInfo.favoriteList.contains(itemId){
                UserInfo.favoriteList.append(itemId)
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                Common.autoDisapperAlert(self, message: Common.favorite)
            } else {
                guard let index = UserInfo.favoriteList.firstIndex(of: itemId) else{return}
                UserInfo.favoriteList.remove(at: index)
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                Common.autoDisapperAlert(self, message: Common.unfavorite)

            }
            
        case 4: // share
            let shareVC = UIActivityViewController(activityItems: [
                productPictureImageView.image, selectedProduct?.name
            ],
            applicationActivities: nil)
            present(shareVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    
}
// MARK: -  UITableViewDelegate, UITableViewDataSource

extension ProductViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: -  TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 3:
            return "你可能喜歡的商品："
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 3:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        //        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmbedCollectionViewTableViewCell.identifier, for: indexPath) as! EmbedCollectionViewTableViewCell
            cell.lableDelegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductItemInfoTableViewCell.identifier, for: indexPath) as! ProductItemInfoTableViewCell
            var detailText:String = ""
            if let detail = selectedProduct?.detail{
                for (key, value) in detail{
                    //                    print(key, value, "\n")
                    detailText += key + ": "
                    detailText += value + "\n"
                }
                
            }
            
            cell.itemInfoLabel.text = detailText
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmbedProductInTableViewCell.identifier, for: indexPath) as! EmbedProductInTableViewCell
            cell.viewcontroller = self
            cell.showAnotherProduct = { [weak self] product in
                if let productVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
                    // 設定為全螢幕模式
                    productVC.modalPresentationStyle = .fullScreen
                    // 開啟商品畫面
                    productVC.selectedProduct = product
                    self?.navigationController?.pushViewController(productVC, animated: true)
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: -  TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            
            return 150
        } else if indexPath.section == 3 {
            return 550
        } else {
            return UITableView.automaticDimension
        }
    }
    
    private func fetchDataFromServer(){
        guard categoryTags == nil else {
            SearchPage.labelCellWords = categoryTags!.name
            return
        }
        let path = "/getProductCategories"
        guard let item_id = selectedProduct?.item_id else{return}
        let parameter = "?item_id=\(item_id)"
        let apiURL =  NetWorkHandler.host + path + parameter
        guard let url = URL(string: apiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (tagData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let tagData = tagData {
                guard let tags: CategoryTags = NetWorkHandler.parseJson(tagData) else{
                    return
                }
                // 存入離線資料集
                self?.categoryTags = tags
                // 更新tags
                if let cellWords = self?.categoryTags?.name{
                    SearchPage.labelCellWords = cellWords
                    DispatchQueue.main.async {
                        if let cell = self?.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EmbedCollectionViewTableViewCell {
                            cell.collectionView.reloadData()
                        }
                    }
                }
               
            } else { Common.autoDisapperAlert(self!, message: "無法取得資料", duration: 1)}
        }.resume()
        
    }
    
}
extension ProductViewController: EmbedCollectionViewTableViewCellDelegae{
    func didTap(_ keyword: String) {
        if let productVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "ResultCollectionViewController") as? ResultCollectionViewController {
            // 設定為全螢幕模式
            productVC.modalPresentationStyle = .fullScreen
            // 傳入商品分類關鍵字
            productVC.userkeywords = keyword
            // 開啟從商品分類資料庫找商品
            productVC.toSearchCategory = true
            // 更改title
            productVC.title = "搜尋： \(keyword)"
            // 開啟商品畫面
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
}
