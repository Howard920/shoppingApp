//
//  RestaurantTableViewCell.swift
//  UITableViewController_1108
//
//  Created by Howard on 2021/11/9.
//

import UIKit

protocol CellDelegate
{
    func deleteItem(id:Int)
    func buyItem(id:Int)
}

class CollectionTableViewCell: UITableViewCell
{
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var productImage: UIImageView!

    var item_id: Int!
    var delegate:CellDelegate!
    
    
    @IBAction func btn_shop(_ sender: UIButton)
    {
        delegate.buyItem(id: item_id)
    }
    
    @IBAction func btn_cancelProduct(_ sender: UIButton)
    {
        delegate.deleteItem(id: item_id)

        
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
