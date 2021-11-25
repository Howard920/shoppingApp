//
//  ResultAxisHCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/13.
//

import UIKit
protocol ResultAxisHCollectionViewCellDelegate: AnyObject {
    func didTapButton(cell: ResultAxisHCollectionViewCell)
}


class ResultAxisHCollectionViewCell: UICollectionViewCell {
    weak var delegate: ResultAxisHCollectionViewCellDelegate?
    @IBOutlet weak var resultPriceLabel: UILabel!
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var isLikeButton: UIButton!
    
    func setup(_ indexPath: IndexPath){
        resultNameLabel.text = Products.demoRoom[indexPath.row].name
        resultPriceLabel.text = "$ " + Products.demoRoom[indexPath.row].price.description
        resultImageView.image = UIImage(data: Products.demoRoom[indexPath.row].picture!)
        if Products.demoRoom[indexPath.row].isLike {
            isLikeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            isLikeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    
    @IBAction func didTapLikeButton(_ sender: UIButton) {
        delegate?.didTapButton(cell: self)
    }
}
