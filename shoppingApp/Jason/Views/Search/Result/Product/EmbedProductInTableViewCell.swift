//
//  EmbedProductInTableViewCell.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/26.
//

import UIKit

class EmbedProductInTableViewCell: UITableViewCell {
    var showAnotherProduct:((ProductInfo)->Void)?
    var popularItems: [ProductInfo]?
    weak var viewcontroller: UIViewController?
    deinit {
        print("EmbedProductInTableViewCell deinit")
    }
    static let identifier: String = "EmbedProductInTableViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if popularItems == nil {
//            print("fetchPopularItemsFromServer")
            fetchPopularItemsFromServer()
        }
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
     var configureCellSize: CGSize {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        layout?.estimatedItemSize = .zero
        var cellSize: CGSize = .zero
        cellSize.width = UIScreen.main.bounds.width / 2 - 20
        cellSize.height = 300
        return cellSize
     }
    
    
    private func fetchPopularItemsFromServer(){
        guard popularItems == nil else {
//            SearchPage.labelCellWords = categoryTags!.name
            return
        }
        let path = "/popularItems"
        let apiURL =  NetWorkHandler.host + path
        guard let url = URL(string: apiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (popularItemsData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let popularItemsData = popularItemsData {
                guard let popularitems: [ProductInfo] = NetWorkHandler.parseJson(popularItemsData) else{
                    return
                }
                // 存入離線資料集
                self?.popularItems = popularitems
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                // 更新popularItem Cell
                
            } else { print("無法取得資料")}
        }.resume()
        
    }
}

extension EmbedProductInTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: -  CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        
        if let popularItem = popularItems?[indexPath.row]{
            cell.configure(popularItem)
            cell.favoriteItemToChange = { [weak self] msg in
                guard let self = self else{return}
                self.collectionView.reloadItems(at: [indexPath])
                Common.autoDisapperAlert(self.viewcontroller!, message: msg)
            }
            // set image
            if let urlStr = popularItem.media_info,
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
                        print("資料傳輸失敗")
                        
                    case .failure(.networkFailure(let error)):
                        print("網路異常\(error)")
                    }
                }
            }
        }
        
        return cell
        
    }
    
    // MARK: -  CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product =  popularItems?[indexPath.row] else{
            print("popularItems have no value")
            return
        }
        showAnotherProduct?(product)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return configureCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}
