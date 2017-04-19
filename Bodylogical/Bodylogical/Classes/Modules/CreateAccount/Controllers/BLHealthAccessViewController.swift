//
//  BLHealthAccessViewController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/19.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import HealthKit

class BLHealthAccessViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var desiredInsights: String?
    var sleepAnalysis: BLSleepAnalysisModel?
    var calorieIntake: String?
    var activeCalorie: String?
    
    var bloodPressureSystolic: String?
    var bloodPressureDiastolic: String?
    var bloodGlucose: String?
    
    var cholesterol: String?
    var weight: String?
    
    var selectIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Health Access"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain , target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done , target: self, action: #selector(done))
        tableView.estimatedRowHeight = 44
        registerTableViewCells()
        getDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerTableViewCells() {
        tableView.registerNibWithCell(BLHeartCell.self)
        tableView.registerNibWithCell(BLDescriptionCell.self)
        tableView.registerNibWithCell(BLPersonalDataCell.self)
        tableView.registerNibWithCell(BLSegmentCell.self)
        tableView.registerHeaderFooterViewNib(BLHeaderView.self)
    }
    
    func getDataSource() {
        sleepAnalysis = BLSleepAnalysisModel()
        BLHealthKitManager.sharedInstance.getBedTimeBySleepType(completion: { (value, error) in
            self.sleepAnalysis = value
        })
        
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.activeEnergyBurned) { (quantity, error) in
            let calorie = NSNumber(floatLiteral: (quantity?.doubleValue(for: HKUnit.calorie())) ?? 0).stringValue
            self.activeCalorie = calorie
        }
        
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.basalEnergyBurned) { (quantity, error) in
            let calorie = NSNumber(floatLiteral: (quantity?.doubleValue(for: HKUnit.calorie())) ?? 0).stringValue
            self.calorieIntake = calorie
        }
        
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.bloodPressureSystolic) { (quantity, error) in
            let calorie = NSNumber(floatLiteral: (quantity?.doubleValue(for: HKUnit.millimeterOfMercury())) ?? 0).stringValue
            self.bloodPressureDiastolic = calorie
        }
        
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.bloodPressureDiastolic) { (quantity, error) in
            let calorie = NSNumber(floatLiteral: (quantity?.doubleValue(for: HKUnit.millimeterOfMercury())) ?? 0).stringValue
            self.bloodPressureDiastolic = calorie
        }
        
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.bloodGlucose) { (quantity, error) in
            print("bloodGlucose = \(error)")
            let value = NSNumber(floatLiteral: (quantity?.doubleValue(for: HKUnit.joule())) ?? 0).stringValue
            self.bloodGlucose = value
        }
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.dietaryCholesterol) { (quantity, error) in
            print("dietaryCholesterol = \(error)")
            let value = NSNumber(floatLiteral: (quantity?.doubleValue(for: HKUnit.millimeterOfMercury())) ?? 0).stringValue
            self.cholesterol = value
        }
        
        BLHealthKitManager.sharedInstance.getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier.bodyMass) { (quantity, error) in
            print("bodyMass = \(error)")
         
            let value = NSNumber(floatLiteral: ((quantity?.doubleValue(for: HKUnit.gram())) ?? 0)/1000).stringValue
            self.weight = value
        }
    }

    func cancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func done() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        BLManager.shareInstance.setRootViewController(isAuthorized: true)
    }
    
    func selectButtonAction(button: UIButton) {
        switch button.tag {
        case 100:
            let pickerVC = BLPickerViewController(nibName: "BLPickerViewController", bundle: nil)
            let dataSource = ["All Available Insights", "Blood Pressure", "Weight Forecast"]
            pickerVC.selectPicker(index: self.selectIndex, dataSource: dataSource as NSArray)
            pickerVC.selectedBackBlock = {[weak self] (selectedText, index)in
                self?.desiredInsights = selectedText
                self?.selectIndex = index
                button.setTitle(self?.desiredInsights, for: .normal)
                
            }
            self.navigationController?.present(pickerVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    //MARK: - TableView Delegate and Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 6
        case 3:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueCell(BLHeartCell.self)
                
                return cell
            case 1:
                let cell = tableView.dequeueCell(BLDescriptionCell.self)
                cell.populateDescription(pageType: .healthAccess)
                return cell
            case 2:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .desiredInsights, data: desiredInsights)
                cell.selectButton.tag = 100
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        case 1:
            let cell = tableView.dequeueCell(BLPersonalDataCell.self)
            switch indexPath.row {
            case 0:
                let ageString = BLHealthKitManager.sharedInstance.getUserAge()
                cell.populatePersonalData(category: .age, data: ageString)
                cell.selectButton.tag = 101
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
            case 1:
                let sexString = BLHealthKitManager.sharedInstance.getUserSex()
                cell.populatePersonalData(category: .sex, data: sexString)
                cell.selectButton.tag = 102
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
            case 2:
                BLHealthKitManager.sharedInstance.getUserHeight(completion: { (heightString, error) in
                    cell.populatePersonalData(category: .height, data: heightString!)
                    
                })
                cell.selectButton.tag = 103
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
            default:
                break
            }
            return cell
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .calorieIntake, data: calorieIntake)
                cell.selectButton.tag = 104
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 1:
                let cell = tableView.dequeueCell(BLSegmentCell.self)
                return cell
            case 2:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .dailyActiveCalories, data: activeCalorie)
                cell.selectButton.tag = 105
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 3:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .averageBedTime, data: (sleepAnalysis?.averageBedTime))
                cell.selectButton.tag = 106
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 4:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .ideaBedTime, data: (sleepAnalysis?.ideaBedTime))
                cell.selectButton.tag = 107
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 5:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .averageWakeTime, data: (sleepAnalysis?.averageWakeTime))
                cell.selectButton.tag = 108
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: Date())
                cell.populatePersonalData(category: .dateOfExam, data: dateString)
                cell.selectButton.tag = 109
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 1:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .bloodPressureWithSystolic, data: bloodPressureSystolic)
                cell.selectButton.tag = 110
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 2:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .bloodPressureWithDiastolic, data: bloodPressureDiastolic)
                cell.selectButton.tag = 111
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 3:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .glucose, data: bloodGlucose)
                cell.selectButton.tag = 112
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            case 4:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .totalCholesterol, data: cholesterol)
                cell.selectButton.tag = 113
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
//            case 5:
//                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
//                cell.populatePersonalData(category: .ldl, data: "170")
//                return cell
            case 5:
                let cell = tableView.dequeueCell(BLPersonalDataCell.self)
                cell.populatePersonalData(category: .weight, data: weight)
                cell.selectButton.tag = 114
                cell.selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section != 0 else {
            return 0.01
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueHeaderFooterViewNib(BLHeaderView.self) as! BLHeaderView
        headerView.contentView.backgroundColor = UIColor.gray
        switch section {
        case 0:
            headerView.titleLabel.text = "Basic"
        case 1:
            headerView.titleLabel.text = "Lifestyle details"
        case 2:
            headerView.titleLabel.text = "Exam Details"
        case 3:
            headerView.titleLabel.text = "Basic"
            
        default:
            break
        }
        return headerView
    }

}
