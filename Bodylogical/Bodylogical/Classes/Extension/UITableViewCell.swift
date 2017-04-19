//
//  UITableViewCell.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/17.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static var className: String{
        return self.description().components(separatedBy: ".").last!
    }
}
