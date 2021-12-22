//
//  RestaurantTableViewCell.swift
//  UITableViewController_1108
//
//  Created by Howard on 2021/11/9.
//

import UIKit

protocol cellDelegate
{
    func deleteItem(row:Int)
    func buyItem(row:Int)
}

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
    
    var row:Int!
    var delegate:cellDelegate!
    
    @IBAction func btn_shop(_ sender: UIButton)
    {
        delegate.buyItem(row: row)
    }
    
    @IBAction func btn_cancelProduct(_ sender: UIButton)
    {
        delegate.deleteItem(row: row)

        
    }
    
    @IBAction func btn_cart(_ sender: UIButton)
    {
        
//        print(UserInfo.cartList)
        if !UserInfo.cartList.contains(1)
        {
            UserInfo.cartList.append(1)
            print(UserInfo.cartList)
        }

    }
    
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
