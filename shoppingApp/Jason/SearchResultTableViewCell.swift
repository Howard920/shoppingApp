//
//  SearchResultTableViewCell.swift
//  HappyShop
//
//  Created by jason on 2021/10/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var loverButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
