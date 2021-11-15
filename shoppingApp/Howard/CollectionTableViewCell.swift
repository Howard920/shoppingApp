//
//  RestaurantTableViewCell.swift
//  UITableViewController_1108
//
//  Created by Howard on 2021/11/9.
//

import UIKit

class CollectionTableViewCell: UITableViewCell
{
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var DiscountLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
//    {   //設定圖片為『圓形』
//        didSet        //以程式碼方式控制 圓角半徑
//        {             //將半徑設為：圖片寬度的一半(1/2)
//            productImage.layer.cornerRadius = productImage.bounds.height / 2
//            productImage.clipsToBounds = true
//        }
//    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
