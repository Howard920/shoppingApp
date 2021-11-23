//
//  ViewController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/10/20.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet var catrgoryCollectionViews: [UICollectionView]!
    @IBOutlet weak var categoryPageControl: UIPageControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var productCollectionView: ProductCollectionView!
    @IBOutlet weak var productCollectionViewHeight: NSLayoutConstraint!
    
    private var viewModel = MainPageViewModel()
    private let fullScreenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem
        setCategoryCollectionViews()
        productCollectionViewHeight.constant = (((UIScreen.main.bounds.width - 30) / 2 + 125) + 10) * 3
    }
    
    func setCategoryCollectionViews(){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: (fullScreenSize.width - 310)/6 + 5, bottom: 15, right: (fullScreenSize.width - 310)/6 + 5
        )
        
        layout.minimumInteritemSpacing = (fullScreenSize.width - 310)/6
        
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(
            width: 50,
            height: 70
        )
        catrgoryCollectionViews[0].collectionViewLayout = layout
        catrgoryCollectionViews[1].collectionViewLayout = layout
        
        catrgoryCollectionViews[0].register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        catrgoryCollectionViews[1].register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        catrgoryCollectionViews[0].dataSource = self
        catrgoryCollectionViews[1].dataSource = self
        catrgoryCollectionViews[0].delegate = self
        catrgoryCollectionViews[1].delegate = self
    }
}

//MARK: - UICollectionViewDataSource Methods

extension MainPageViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        if collectionView == catrgoryCollectionViews[0]{
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

extension MainPageViewController: UIScrollViewDelegate{
    
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

extension MainPageViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCategory", sender: self)
    }
}

