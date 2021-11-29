//
//  MemberInfo.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/11/25.
//

import UIKit

class MemberInfo: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
