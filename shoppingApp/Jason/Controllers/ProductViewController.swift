//
//  ProductViewController.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/18.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var productPictureImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBOutlet weak var productIsLikeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        myInit()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // show tab bar
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func myInit(){
        // hide tab bar
        self.tabBarController?.tabBar.isHidden = true
        // set tabview delegate
        tableView.delegate = self
        tableView.dataSource = self
        
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
        guard let name = Products.selectProduct?.name,
              let price = Products.selectProduct?.price.description,
              let picture = UIImage(data: (Products.selectProduct?.picture)!),
              let isLike = Products.selectProduct?.isLike
        else { return }
        productTitleLabel.text = name
        productPriceLabel.text = "$ " + price
        productPictureImageView.image = picture
        if isLike {
            productIsLikeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            productIsLikeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
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
        badgeCount.text = "99"
        return badgeCount
    }
    
    
    @IBAction func isLikeButtonClick(_ sender: Any) {
        
        print("i like  \(productTitleLabel.text ?? "")")
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        //        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmbedCollectionViewTableViewCell.identifier, for: indexPath) as! EmbedCollectionViewTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductItemInfoTableViewCell.identifier, for: indexPath) as! ProductItemInfoTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmbedProductInTableViewCell.identifier, for: indexPath) as! EmbedProductInTableViewCell
//            cell.toNewController = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: -  TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
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
    
}


