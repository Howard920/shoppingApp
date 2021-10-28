//
//  ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var adScrollView: UIScrollView!
    @IBOutlet weak var adPageControl: UIPageControl!
    @IBOutlet var adImages: [UIImageView]!
    @IBOutlet var collectionViews: [UICollectionView]!
    @IBOutlet weak var categoryPageControl: UIPageControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var productCollectionViewHeight: NSLayoutConstraint!
    
    private var viewModel = WelcomeViewModel()
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
        productCollectionViewHeight.constant = (((self.view.frame.width - 30) / 2 + 120) + 10) * 3 + 10
    }

    override func viewWillLayoutSubviews() {
        upadteImageColor()
    }
    
    override func viewDidLayoutSubviews() {
        
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
        collectionViews[0].delegate = self
        collectionViews[1].delegate = self
    }
}

//MARK: - UICollectionViewDataSource Methods

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

//MARK: - UIScrollViewDelegate Methods

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

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCategory", sender: self)
    }
}
