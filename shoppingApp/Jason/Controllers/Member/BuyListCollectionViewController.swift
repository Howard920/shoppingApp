//
//  BuyListCollectionViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/27.
//

import UIKit

class BuyListCollectionViewController: UICollectionViewController {
    
    var infoButtonState:[Bool] = []
    var orderInfo:[OrderInfo] = []{
        didSet{
            infoButtonState = Array(repeating: false, count: orderInfo.count)
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
        loadDataFromServer()
    }
    
    
    private func loadDataFromServer(){
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
        let product = orderInfo[indexPath.section].product_list[indexPath.row]
        cell.nameLabel.text = product.item.name
        cell.priceLabel.text = product.item.price.description
        cell.itemSpec.text = "無"
        cell.numberOfItemLabel.text = product.item_count.description
        cell.shipmentStateLabel.text = "已送達"
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
