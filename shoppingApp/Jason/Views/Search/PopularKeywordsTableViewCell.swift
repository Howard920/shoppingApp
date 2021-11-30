//
//  PopularKeywordsTableViewCell.swift
//  CollectionViewDemo
//
//  Created by Jason Deng on 2021/11/9.
//

import UIKit
protocol PopularKeywordsTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}


class PopularKeywordsTableViewCell: UITableViewCell {
    @IBOutlet var popularButton: [UIButton]!
    weak var delegate: PopularKeywordsTableViewCellDelegate?
//    private let buttonTitle: String = ""
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    @IBAction func didTapButton(_ sender: UIButton){
        delegate?.didTapButton(with: sender.currentTitle!)
    }
    
    func configure(with titles: [String]){
        for (index, title) in titles.enumerated(){
            popularButton[index].setTitle(title, for: .normal)
            popularButton[index].layer.cornerRadius = popularButton[index].bounds.height / 3
            popularButton[index].backgroundColor = .clear
            popularButton[index].layer.borderWidth = 1
            popularButton[index].layer.borderColor = UIColor.black.cgColor
        }
        
    }

}
