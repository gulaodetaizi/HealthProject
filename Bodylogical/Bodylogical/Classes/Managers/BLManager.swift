//
//  BLManager.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/19.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLManager: NSObject {
    
    class var shareInstance: BLManager {
        struct Static {
            static var instance: BLManager = BLManager()
        }
        
        return Static.instance
    }
    
    func setRootViewController(isAuthorized: Bool) {
    
        if isAuthorized {
        
            let rootVC = BLMainTabBarController()
            let loginNav = UINavigationController(rootViewController: rootVC)
            rootVC.title = "John Smith Summary"
            UIApplication.shared.delegate?.window??.rootViewController = loginNav
            
        } else {
            let loginVC = BLUtilities.loadViewControllerFromMainStoryboard(name: "BLLoginTableViewController")
            let loginNav = UINavigationController(rootViewController: loginVC)
            UIApplication.shared.delegate?.window??.rootViewController = loginNav
        }
    }
}
