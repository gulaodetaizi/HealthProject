//
//  BLRoundButton.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/17.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLRoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    required init?(coder aDecode: NSCoder) {
        super.init(coder: aDecode)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }

}
