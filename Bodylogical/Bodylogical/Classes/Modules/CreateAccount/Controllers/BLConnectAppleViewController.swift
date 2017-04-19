//
//  BLConnectAppleViewController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/17.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import HealthKit

class BLConnectAppleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var height: HKQuantitySample?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Connect to Apple Health"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.plain, target: self, action: #selector(skipAction))
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.backBarButtonItem = nil
        self.tableView.estimatedRowHeight = 44
        registerTableViewCells()
    }
    
    func registerTableViewCells() {
    
        tableView.registerNibWithCell(BLHeartCell.self)
        tableView.registerNibWithCell(BLDescriptionCell.self)
        tableView.registerNibWithCell(BLCreateAccountButtonCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueCell(BLHeartCell.self)
            return cell
        case 1:
            let cell = tableView.dequeueCell(BLDescriptionCell.self)
            cell.populateDescription(pageType: .connectApple)
            return cell
        case 2:
            let cell = tableView.dequeueCell(BLCreateAccountButtonCell.self)
            cell.CreateAccountBtn.setTitle("Connect to Apple Health", for: .normal)
            cell.CreateAccountBtn.addTarget(self, action: #selector(connectAppleHealth), for: .touchUpInside)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func connectAppleHealth() {
        BLHealthKitManager.sharedInstance.authorizeHealthKit { (success, error) in
//            if success {
//            }
            let healthAccessVC = BLHealthAccessViewController(nibName: "BLHealthAccessViewController", bundle: nil)
            let healthAccessNav = BLBaseNavigationController(rootViewController: healthAccessVC)
            self.navigationController?.present(healthAccessNav, animated: true, completion: nil)
        }
    }
    
    func skipAction() {
        
        BLUtilities.showAlert("", message: "Are you sure you do not want to sync with Apple Health? Doing so helps minimize data entry and improve Bodylogical forecasts.", leftName: "Not Now", rightName: "Sync", inViewController: self) { (result) in
            if result {
                self.connectAppleHealth()
            }
        }
    }

//    func setHeight() {
//        // Create the HKSample for Height.
//        
//        let heightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
//
//        
//        // Call HealthKitManager's getSample() method to get the user's height.
//        BLHealthKitManager.sharedInstance.getUserHeight(sampleType: heightSample!, completion: { (userHeight, error) -> Void in
//            
//            if( error != nil ) {
//                print("Error: \(error?.localizedDescription)")
//                return
//            }
//            
//            var heightString = ""
//            
//            self.height = userHeight as? HKQuantitySample
//            
//            // The height is formatted to the user's locale.
//            if let meters = self.height?.quantity.doubleValue(for: HKUnit.meter()) {
//                let formatHeight = LengthFormatter()
//                formatHeight.isForPersonHeightUse = true
//                heightString = formatHeight.string(fromMeters: meters)
//            }
//            
//            // Set the label to reflect the user's height.
////            DispatchQueue.main.asynchronously(execute: { () -> Void in
//                //                        self.heightLabel.text = heightString
////            })
//        })
//        
//    }

}
