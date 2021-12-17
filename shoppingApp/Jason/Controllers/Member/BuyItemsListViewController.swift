//
//  BuyItemsListViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/29.
//

import UIKit

class BuyItemsListViewController: UIViewController {
    //    var items:Set<ProductInfo> = []
//    var products:[ProductInfo] = []
    var resultProductsInfo:[ProductInfo]?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        layout.minimumInteritemSpacing = 10
        
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 30) / 2 ,
            height: (UIScreen.main.bounds.width - 30) / 2 + 125
        )
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromServer()
    }
    
    private func fetchDataFromServer(){
        let path = "/getOrder"
        let parameter = "?member_id_phone=\(UserInfo.member_id_phone)"
        let apiURL =  NetWorkHandler.host + path + parameter
        let url = URL(string: apiURL)!
        let request = URLRequest(url: url)
        var items:Set<ProductInfo> = []
        URLSession.shared.dataTask(with: request) { [weak self] (getOrderData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let getOrderData = getOrderData {
                guard let orderList: [OrderInfo] = NetWorkHandler.parseJson(getOrderData) else{
                    if let msg = String(data: getOrderData, encoding: .utf8){
                        DispatchQueue.main.async {
                            // 無訂單資料, 用UILabel顯示訊息
                            let msgLabel = UILabel()
                            msgLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
                            msgLabel.textAlignment = .center
                            msgLabel.text = msg
                            self?.collectionView.addSubview(msgLabel)
                        }
                    }
                    return
                }
                // 篩選不重覆的商品存入Set無序陣列
                for order in orderList {
                    for product in order.product_list{
                        items.insert(product.item)
                    }
                }
                // 把set存入陣列, 方便cell初使化使用
                self?.resultProductsInfo = items.sorted(by: { (item1, item2) -> Bool in
                    item1.item_id < item2.item_id
                })
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }.resume()
    }
    
    
    
}

extension BuyItemsListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    // delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let productVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            // 設定為全螢幕模式
            productVC.modalPresentationStyle = .fullScreen
            // 開啟商品畫面
            productVC.selectedProduct = resultProductsInfo?[indexPath.row]
            navigationController?.pushViewController(productVC, animated: true)
        }
    }
    
    
    // data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultProductsInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        if !resultProductsInfo!.isEmpty{
            cell.pictureImageView.image = nil
            // 設定cell裡面buttons的tagID
            cell.isLikeButton.tag = indexPath.row
            cell.cartButton.tag = indexPath.row
            if let productInfo = resultProductsInfo?[indexPath.row]{
                cell.configure(productInfo)
                cell.nameLabel.text = productInfo.name
                cell.priceLabel.text = "$" +  productInfo.price.description
                // 設定Button狀態
                if UserInfo.cartList.contains(productInfo.item_id){
                    cell.cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)

                } else {
                    cell.cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
                }
                
                if UserInfo.favoriteList.contains(productInfo.item_id){
                    cell.isLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    cell.isLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
            
            
            // 綁定Button點擊事件
            cell.isLikeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: .touchUpInside)
            cell.cartButton.addTarget(self, action: #selector(cartButtonClick(_:)), for: .touchUpInside)
            cell.pictureImageView.image = nil
     
            // fetch image from web
            if let url = resultProductsInfo?[indexPath.row].media_info!,
               let myURL = URL(string: url){
                URLSession.shared.dataTask(with: myURL) { (data, response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    guard let data = data else {return}
                    
                    DispatchQueue.main.async {
                        cell.pictureImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
        
        return cell
    }
    
    
    // MARK: -  cell Button點擊事件
    @objc func likeButtonClick(_ sender: UIButton){
        let row = sender.tag
        if let itemID = resultProductsInfo?[row].item_id {
            // 如果收藏清單內沒有收藏這個商品，就加入清單。
            if !UserInfo.favoriteList.contains(itemID){

                UserInfo.favoriteList.append(itemID)
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                Common.autoDisapperAlert(self, message: Common.favorite)
                collectionView.reloadData()
            } else {
                guard let index = UserInfo.favoriteList.firstIndex(of: itemID) else{return}
                UserInfo.favoriteList.remove(at: index)
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                Common.autoDisapperAlert(self, message: Common.unfavorite)
                collectionView.reloadData()
            }
        }
    }
    @objc func cartButtonClick(_ sender: UIButton){
        let row = sender.tag
        if let itemID = resultProductsInfo?[row].item_id {
            // 如果購物車清單內沒有這個商品，就加入清單。
            if !UserInfo.cartList.contains(itemID){
                UserInfo.cartList.append(itemID)
                sender.setImage(UIImage(systemName: "cart.fill"), for: .normal)
                Common.autoDisapperAlert(self, message: Common.cart)
                collectionView.reloadData()
            } else {
                guard let index = UserInfo.cartList.firstIndex(of: itemID) else{return}
                UserInfo.cartList.remove(at: index)
                sender.setImage(UIImage(systemName: "cart"), for: .normal)
                Common.autoDisapperAlert(self, message: Common.uncart)
                collectionView.reloadData()
            }
        }
    }

    
}
