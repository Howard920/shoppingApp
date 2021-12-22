//
//  ResultCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/13.
//

import UIKit


class ResultCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var cellLayoutBarButton: UIBarButtonItem!
    var userkeywords:String = ""
    var headerText:String = ""
    var toSearchCategory = false
    // 離線資料集，符合userkeywords的商品
    var resultProductsInfo:[ProductInfo]?
    
    
    deinit {
        print(userkeywords + "deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myInit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCellSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromServer()
    }
    
    private func fetchDataFromServer(){
        guard resultProductsInfo == nil else {
            return
        }
        var path = "/search"
        var parameter = "?keywords=\(userkeywords)"

        if toSearchCategory {
            path = "/product"
            parameter = "?category=\(userkeywords)"
        }
        
        let apiURL =  NetWorkHandler.host + path + parameter
        guard let url = URL(string: apiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (keywordsSearchData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let keywordsSearchData = keywordsSearchData {
                guard let searchResultData: [ProductInfo] = NetWorkHandler.parseJson(keywordsSearchData) else{
                    if let msg = String(data: keywordsSearchData, encoding: .utf8){
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
                // 存入離線資料集
                self?.resultProductsInfo = searchResultData
//                self?.resultProductsInfo = searchResultData.filter({ (productInfo) -> Bool in
//                    return productInfo.name.contains(self!.userkeywords)
//                })
                // 設定SectionTitle
                if let number = self?.resultProductsInfo?.count{
                    self?.headerText = "\(number)個商品符合"
                }
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } else { Common.autoDisapperAlert(self!, message: "無法取得資料", duration: 1)}
        }.resume()
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
    
    
    func myInit(){
        // 隠藏navigationBar的返回鈕的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // set cell layout style
        cellLayoutBarButton.image = UIImage(systemName: SearchPage.cellStyleButtonImageName)
        
        // MARK: -  cell Register
        collectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
        collectionView.register(ProductListHAxisCell.nib(), forCellWithReuseIdentifier: ProductListHAxisCell.identifier)
        collectionView.register(HeaderReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier)
        
        collectionView.backgroundColor = .systemGray3
    }
    
    // MARK: -  依layoutSytle改變Cell的寬高尺寸
    func configureCellSize() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = .zero
        var height = CGFloat.zero
        var width = CGFloat.zero
        // two cells in a row
        if SearchPage.isCellListLayout {
            layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 10
            width = UIScreen.main.bounds.width
            height = 150
            
        } else {
            // one cell in a row
            layout?.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            layout?.minimumInteritemSpacing = 5
            layout?.minimumLineSpacing = 10
            width = (UIScreen.main.bounds.width - 30) / 2
            height = 300
        }
        layout?.itemSize = CGSize(width: width, height: height)
        
    }
    
    // MARK: -  layoutChange
    @IBAction func changeLayout(_ sender: UIBarButtonItem) {
        SearchPage.isCellListLayout = !SearchPage.isCellListLayout
        sender.image = UIImage(systemName: SearchPage.cellStyleButtonImageName)
        collectionView.reloadData()
    }
    
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as! HeaderReusableView
        headerView.headerLabel.text = headerText
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Get the view for the first header
            let indexPath = IndexPath(row: 0, section: section)
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        var size = headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.maxX - 40, height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
        size.height += 20
        return size

    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultProductsInfo?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if SearchPage.isCellListLayout {
            // one cell in a row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListHAxisCell.identifier, for: indexPath) as! ProductListHAxisCell
            // 設定cell裡面buttons的tagID
            cell.isLikeButton.tag = indexPath.row
            cell.cartButton.tag = indexPath.row
            // 綁定Button點擊事件
            cell.isLikeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: .touchUpInside)
            cell.cartButton.addTarget(self, action: #selector(cartButtonClick(_:)), for: .touchUpInside)
            cell.pictureImageView.image = nil
            if let productInfo = resultProductsInfo?[indexPath.row]{
                cell.configure(productInfo)
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
                
                // set image
                if let urlStr = productInfo.media_info,
                   let url = URL(string: urlStr)  {
                    let imageURL = url
                    let imageLoader = ImageLoader()

                    imageLoader.loadImage(at: imageURL) { result in
                        switch result {
                        case .success(let image):
                            DispatchQueue.main.async {
                                cell.pictureImageView.image = image
                            }
                        case .failure(.invalidData):
                            Common.autoDisapperAlert(self, message: "資料傳輸失敗", duration: 1)
                            
                        case .failure(.networkFailure(let error)):
                            Common.autoDisapperAlert(self, message: "網路異常\(error)", duration: 1)
                        }
                    }
                }
            }

            return cell
            
        } else {
            // two cells in a row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
            // 設定cell裡面buttons的tagID
            cell.isLikeButton.tag = indexPath.row
            cell.cartButton.tag = indexPath.row
            // 綁定Button點擊事件
            cell.isLikeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: .touchUpInside)
            cell.cartButton.addTarget(self, action: #selector(cartButtonClick(_:)), for: .touchUpInside)
            cell.pictureImageView.image = nil

            if let productInfo = resultProductsInfo?[indexPath.row]{
                cell.configure(productInfo)
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
                
                // set image
                if let urlStr = productInfo.media_info,
                   let url = URL(string: urlStr)  {
                    let imageURL = url
                    let imageLoader = ImageLoader()

                    imageLoader.loadImage(at: imageURL) { result in
                        switch result {
                        case .success(let image):
                            DispatchQueue.main.async {
                                cell.pictureImageView.image = image
                            }
                        case .failure(.invalidData):
                            Common.autoDisapperAlert(self, message: "資料傳輸失敗", duration: 1)
                            
                        case .failure(.networkFailure(let error)):
                            Common.autoDisapperAlert(self, message: "網路異常\(error)", duration: 1)
                        }
                    }
                }
            }
            return cell
        }
        
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedProduct = resultProductsInfo?[indexPath.row]{
            performSegue(withIdentifier: "ProductViewController", sender: selectedProduct)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productController = segue.destination as! ProductViewController
        productController.selectedProduct = sender as? ProductInfo
    }
    
}
