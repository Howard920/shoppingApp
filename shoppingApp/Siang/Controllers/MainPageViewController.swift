//
//  ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionViews: [UICollectionView]!
    @IBOutlet weak var categoryPageControl: UIPageControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var productCollectionViewHeight: NSLayoutConstraint!
    
    private var viewModel = WelcomeViewModel()


    private let fullScreenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViews()
        productCollectionViewHeight.constant = (((UIScreen.main.bounds.width - 30) / 2 + 125) + 10) * 3
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
        
        if scrollView == categoryScrollView{
            if scrollView.contentOffset.x == 0{
                categoryPageControl.currentPage = 0
            }
            
            if scrollView.contentOffset.x == categoryScrollView.bounds.width {
                categoryPageControl.currentPage = 1
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCategory", sender: self)
    }
}

