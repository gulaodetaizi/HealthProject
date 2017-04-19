//
//  BLHeartCell.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/18.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLHeartCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
