//
//  BLMainTabBarController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/19.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createSubViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSubViewControllers() {
        let informationVC = BLInsightsViewController(nibName: "BLInsightsViewController", bundle: nil)
        let informationNac = UINavigationController(rootViewController: informationVC)
        informationNac.title = "Insights"
        informationNac.tabBarItem.image = UIImage(named: "undeImg")
        
        let homeVC = BLInterventionsViewController(nibName: "BLInterventionsViewController", bundle: nil)
        let rootNav = UINavigationController(rootViewController: homeVC)
        rootNav.title = "Interventions"
        rootNav.tabBarItem.image = UIImage(named: "undeImg")
        
        let mySelfVC = BLGoalsViewController(nibName: "BLGoalsViewController", bundle: nil)
        let mySelfNac = UINavigationController(rootViewController: mySelfVC)
        mySelfNac.title = "Goals"
        mySelfNac.tabBarItem.image = UIImage(named: "undeImg")
        
        let SelfVC = BLProfileViewController(nibName: "BLProfileViewController", bundle: nil)
        let SelfNac = UINavigationController(rootViewController: SelfVC)
        SelfNac.title = "Profile"
        SelfNac.tabBarItem.image = UIImage(named: "undeImg")
        
        self.viewControllers = [informationNac, rootNav, mySelfNac, SelfNac]
        self.selectedViewController = self.viewControllers?[0]
    }
    


}
