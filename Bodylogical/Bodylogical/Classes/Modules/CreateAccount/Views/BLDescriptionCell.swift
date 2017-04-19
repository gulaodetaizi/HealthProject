//
//  BLDescriptionCell.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/18.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateDescription(pageType: BLPageType) {
        switch pageType {
        case .connectApple:
            let descString = "Bodylogical is most insightful when linked to your health data. Connecting to HealthKit allows for increased personalization and precision.\n\nYou data will only be used to personalize predictions and improve analysis. We will never use it without your permission and will never sell or disclose it to third parties for commercial usage.\n\nLearn more about our privacy policy."
            
            let numberStr = "Learn more"
            let guideStr = descString as NSString
            let allRange = guideStr.range(of: descString)
            let range = guideStr.range(of: numberStr)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let titleAttributedStr = NSMutableAttributedString(string: guideStr as String)
            titleAttributedStr.addAttribute(NSFontAttributeName, value: FONT_NORMAL14!, range: NSMakeRange(0, allRange.length))
            titleAttributedStr.addAttributes([NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName : FONT_BOLD14!], range: range)
            
            titleAttributedStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, titleAttributedStr.length))
            self.contentLabel.attributedText = titleAttributedStr
        case .healthAccess:
            let descString = "Bodylogical can provide a range of different personalized insights and uses your own data to enable improved accuracy. Select the insights you would like to see below and enter the requested information to begin your health forecast."
            self.contentLabel.text = descString
        }
        
    }
    
}
