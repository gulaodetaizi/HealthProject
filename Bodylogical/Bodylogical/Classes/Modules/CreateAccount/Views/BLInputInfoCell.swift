//
//  BLInputInfoCell.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/17.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLInputInfoCell: UITableViewCell {
    
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
