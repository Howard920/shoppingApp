//
//  Cart2TableViewCell.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/15.
//

import UIKit

protocol Cart2TableViewCellDelegate: AnyObject{
    func cell_btn_select(at indexPath: IndexPath)
}

class Cart2TableViewCell: UITableViewCell {

    @IBOutlet weak var btn_radio: UIButton!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_price: UILabel!
    
    weak var delegate: Cart2TableViewCellDelegate?
    var indexPath: IndexPath!
    var is_btn_selected = false{
        didSet{
            if is_btn_selected{
                self.btn_radio.setImage(UIImage(named: "radioChecked"), for: .normal)
            }else{
                self.btn_radio.setImage(UIImage(named: "radioUnchecked"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lb_price.text = ""
    }

    @IBAction func btn_radio_pressed(_ sender: UIButton) {
        delegate?.cell_btn_select(at: indexPath)
    }
    
}
