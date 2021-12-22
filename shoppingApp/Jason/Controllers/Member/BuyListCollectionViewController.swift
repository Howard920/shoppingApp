//
//  BuyListCollectionViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/27.
//

import UIKit

class BuyListCollectionViewController: UICollectionViewController {
    
    var infoButtonState:[Bool] = []
    var returnList:[ReturnItems]?
    var itemShipmentState:[Int:[String]]=[:]
    var orderInfo:[OrderInfo] = []{
        didSet{
            infoButtonState = Array(repeating: false, count: orderInfo.count)
            setItemState()
            applyReturnItems(isCheck: true)
        }
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BuyListHeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BuyListHeaderCollectionReusableView.identifier)
        
        collectionView!.register(BuyListInfoCellCollectionViewCell.nib(), forCellWithReuseIdentifier: BuyListInfoCellCollectionViewCell.identifier)
        // 向Server拿member資料
        fetchDataFromServer()
    }
    private func setItemState(_ indexPath: IndexPath? = nil, _ itemState: String? = nil){
        guard let indexPath = indexPath, let itemState = itemState else {
            var state:[String] = []
            for (index, orders) in orderInfo.enumerated(){
                state = Array(repeating: "已送達", count: orders.product_list.count)
                itemShipmentState[index] = state
            }
            return
        }
        itemShipmentState[indexPath.section]?[indexPath.row] = itemState
        
        print(itemShipmentState)
    }
    
    
    private func applyReturnItems(isCheck:Bool=false, indexPath: IndexPath=IndexPath.init(), order_id: Int=0, item_id: Int=0, item_count:Int=0){
        let path = "/returnItems"
        var parameter = "?member_id_phone=\(UserInfo.member_id_phone)"
        // 檢查有無退貨記錄
        if isCheck{
            parameter += "&check=1"
        } else { // 新增退貨
            parameter += "&order_id=\(order_id)&item_id=\(item_id)&item_count=\(item_count)"
        }
        let apiURL =  NetWorkHandler.host + path + parameter
        let url = URL(string: apiURL)!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else{return}
            // 查詢退貨
            if let returnList: [ReturnItems] = NetWorkHandler.parseJson(data){
                self?.returnList = returnList
                if indexPath.isEmpty{
                    print("indexPath  empty", indexPath)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }else {
                    print("indexPath not empty", indexPath)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadItems(at: [indexPath])
                    }
                }
                
            // 新增退貨
            }else{
                if let returnItem: ReturnItems = NetWorkHandler.parseJson(data){
                    if self?.returnList != nil{
                        self?.returnList?.append(returnItem)
                    }else {
                        self?.returnList = [returnItem]
                    }
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadItems(at: [indexPath])
                        self?.applyReturnItems(isCheck: true, indexPath: indexPath)
                    }
                }else{
                    if let msg = String(data: data, encoding: .utf8){
                        guard let self = self else{return}
                        switch msg {
//                        case "退貨已提交":
//                            break
                        case "無退貨記錄":
                            break
                        case "已送件申請", "退貨已提交":
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                                self.collectionView.reloadItems(at: [indexPath])
                                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                                self.present(alert, animated: true, completion: nil)
                                self.dismiss(animated: true, completion: nil)
                            }
                        default:
                            break
                        }
                    }
                }
            }
        }.resume()
    }
    
    private func fetchDataFromServer(){
        let path = "/getOrder"
        let parameter = "?member_id_phone=\(UserInfo.member_id_phone)"
        let apiURL =  NetWorkHandler.host + path + parameter
        let url = URL(string: apiURL)!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (getOrderData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let getOrderData = getOrderData {
                guard let order: [OrderInfo] = NetWorkHandler.parseJson(getOrderData) else{
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
                self?.orderInfo = order
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }.resume()
    }
    
    @objc func moreInfo(_ sender: UIButton){
        let section = sender.tag
        infoButtonState[section] = !infoButtonState[section]
        collectionView.reloadSections(IndexSet(integer: section))
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return orderInfo.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if infoButtonState[section] {
            return orderInfo[section].product_list.count
        } else {
            return 0
            
        }
    }
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BuyListHeaderCollectionReusableView.identifier, for: indexPath) as! BuyListHeaderCollectionReusableView
        headerView.moreInfoButton.tag = indexPath.section
        headerView.moreInfoButton.addTarget(self, action: #selector(moreInfo(_:)), for: .touchUpInside)
        // 訂單日期
        headerView.dateLabel.text = orderInfo[indexPath.section].order_date
        // 訂單編號
        headerView.orderIdLabel.text = orderInfo[indexPath.section].order_id.description
        // 運送方式
        headerView.deliveryLabel.text = orderInfo[indexPath.section].shipment
        // 付款方式
        headerView.paymentLabel.text = orderInfo[indexPath.section].payment
        // 消費者住址
        headerView.addressLabel.text = orderInfo[indexPath.section].order_person_address
        // 訂單金額
        headerView.priceLabel.text = orderInfo[indexPath.section].price.description
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return configureCellSize()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuyListInfoCellCollectionViewCell.identifier, for: indexPath) as! BuyListInfoCellCollectionViewCell
        // 取出每個商品資訊
        let order = orderInfo[indexPath.section]
        let product = order.product_list[indexPath.row]
//        let itemsState = itemShipmentState[indexPath.section]
        let returnItem = returnList?.filter({ (returnItem) -> Bool in
            print(returnItem)
            return order.order_id == returnItem.order_id && product.item.item_id == returnItem.item_id
        }).first
        print("itemsState", returnItem?.state)
        let itemState = returnItem?.state ?? "已送達"
        cell.configure(product, itemState)
        cell.returnEvent = { [weak self] in
            self?.applyReturnItems(indexPath: indexPath, order_id: order.order_id, item_id: product.item.item_id, item_count: product.item_count)
        }
        return cell
    }
    
    private func configureCellSize(_ style: Int = 0) -> CGSize {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        var customSize = CGSize.zero
        // section layout
        if style == 0 {
            // 設定Cell尺寸
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 0
            customSize.width = UIScreen.main.bounds.width
            customSize.height = 200
        } else { // cell layout
            // 設定Cell尺寸
            layout?.minimumInteritemSpacing = 0
            layout?.minimumLineSpacing = 1
            customSize.width = UIScreen.main.bounds.width - 20
            customSize.height = 300
        }
        
        return customSize
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print(indexPath)
    }
    
}

extension BuyListCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return configureCellSize(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
}
