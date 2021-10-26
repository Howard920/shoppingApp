//
//  ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/20.
//

import UIKit

struct ColorElement {
    var color: UIColor{
        return UIColor(named: String(indexOfAllColor))!
    }
    var indexOfAllColor: Int
}

struct Category{
    var title: String
    var image: UIImage
}

class ViewModel {
    var colorOfViews = [ColorElement(indexOfAllColor: 4), ColorElement(indexOfAllColor: 0), ColorElement(indexOfAllColor: 1), ColorElement(indexOfAllColor: 2), ColorElement(indexOfAllColor: 3)]
    var numOfAllColor = 5
    
    var categories = [Category(title: "防疫商品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "冷凍店取", image: UIImage(named: "Candles-icon")!),
                      Category(title: "箱購飲料", image: UIImage(named: "Candles-icon")!),
                      Category(title: "甜點蛋糕", image: UIImage(named: "Candles-icon")!),
                      Category(title: "素食蔬食", image: UIImage(named: "Candles-icon")!),
                      Category(title: "水產海鮮", image: UIImage(named: "Candles-icon")!),
                      Category(title: "生鮮肉品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "3C週邊", image: UIImage(named: "Candles-icon")!),
                      Category(title: "生活日用", image: UIImage(named: "Candles-icon")!),
                      Category(title: "餅乾零食", image: UIImage(named: "Candles-icon")!),
                      Category(title: "熟食小吃", image: UIImage(named: "Candles-icon")!),
                      Category(title: "保健商品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "毛小孩", image: UIImage(named: "Candles-icon")!),
                      Category(title: "家具廚具", image: UIImage(named: "Candles-icon")!),
                      Category(title: "美妝用品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "首飾配件", image: UIImage(named: "Candles-icon")!),
                      Category(title: "服飾", image: UIImage(named: "Candles-icon")!),
                      Category(title: "包包提袋", image: UIImage(named: "Candles-icon")!),
                      Category(title: "文創商品", image: UIImage(named: "Candles-icon")!),
                      Category(title: "文/玩具", image: UIImage(named: "Candles-icon")!),
    ]
    
    func lastImage(){
        for viewIndex in 0...2{
            colorOfViews[viewIndex].indexOfAllColor -= 1
            
            if colorOfViews[viewIndex].indexOfAllColor < 0{
                colorOfViews[viewIndex].indexOfAllColor = numOfAllColor - 1
            }
            
        }
    }
    
    func nextImage(){
        for viewIndex in 0...2{
            colorOfViews[viewIndex].indexOfAllColor += 1
            
            if  colorOfViews[viewIndex].indexOfAllColor > numOfAllColor - 1{
                colorOfViews[viewIndex].indexOfAllColor = 0
            }
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var adScrollView: UIScrollView!
    @IBOutlet weak var adPageControl: UIPageControl!
    @IBOutlet var adImages: [UIImageView]!
    @IBOutlet var collectionViews: [UICollectionView]!
    @IBOutlet weak var categoryPageControl: UIPageControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    
    private var viewModel = ViewModel()
    private var didScrollViewSet = false
    private var adTimer: Timer!{
        didSet{
            oldValue?.invalidate()
        }
    }
    private let fullScreenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adPageControl.numberOfPages = viewModel.numOfAllColor
        setCollectionViews()
    }

    override func viewWillLayoutSubviews() {
        upadteImageColor()
    }
    
    override func viewDidLayoutSubviews() {
        print(123)
        didScrollViewSet = true
        adTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(adChange), userInfo: nil, repeats: true)
        
    }
    
    @objc func adChange(){
        
        let offset = CGPoint(x: adImages[1].frame.width * 2 , y: 0)
        adScrollView.setContentOffset(offset, animated: true)
    }
    
    func setCollectionViews(){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: (fullScreenSize.width - 310)/6 + 5, bottom: 15, right: (fullScreenSize.width - 310)/6 + 5
        )
        
        layout.minimumInteritemSpacing = (fullScreenSize.width - 310)/6
        print((fullScreenSize.width - 310)/6)
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(
            width: 50,
            height: 70
        )
        collectionViews[0].collectionViewLayout = layout
        collectionViews[1].collectionViewLayout = layout
        
        collectionViews[0].register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionViews[1].register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        collectionViews[0].dataSource = self
        collectionViews[1].dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        if collectionView == collectionViews[0]{
            cell.titleLabel.text = viewModel.categories[indexPath.row].title
            cell.imageView.image = viewModel.categories[indexPath.row].image
        }else{
            cell.titleLabel.text = viewModel.categories[indexPath.row + 10].title
            cell.imageView.image = viewModel.categories[indexPath.row + 10].image
        }
        
        
        return cell
    }
}

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if scrollView == adScrollView{
            
            if adScrollView.isDragging || adScrollView.isDecelerating{
                adTimer = nil
                adTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(adChange), userInfo: nil, repeats: true)
              
            }
            
            if adScrollView.contentOffset.x == 0, didScrollViewSet{
                
                viewModel.lastImage()
                upadteImageColor()
            }
            
            if scrollView.contentOffset.x == adScrollView.bounds.width * 2 {

                viewModel.nextImage()
                upadteImageColor()
            }
        }
        adPageControl.currentPage = viewModel.colorOfViews[1].indexOfAllColor
        
        if scrollView == categoryScrollView{
            if scrollView.contentOffset.x == 0{
                categoryPageControl.currentPage = 0
            }
            
            if scrollView.contentOffset.x == categoryScrollView.bounds.width {
                categoryPageControl.currentPage = 1
            }
        }
    }
    
    func upadteImageColor(){
        adImages[1].backgroundColor = viewModel.colorOfViews[1].color
        adScrollView.contentOffset.x = adImages[1].frame.width
        
        adImages[2].backgroundColor = viewModel.colorOfViews[2].color
        adImages[0].backgroundColor = viewModel.colorOfViews[0].color
    }
}
