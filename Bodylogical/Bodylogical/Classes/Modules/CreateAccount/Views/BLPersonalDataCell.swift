//
//  BLPersonalDataCell.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/19.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLPersonalDataCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populatePersonalData(category: BLPersonalDataType,data: String?) {
    
        switch category {
        case .desiredInsights:
            self.categoryLabel.text = "Desired Insights"
            if data != nil && (data!.lengthOfBytes(using: String.Encoding.utf8) > 0){
                self.selectButton.setTitle(data, for: .normal)
            } else {
                self.selectButton.setTitle("Select Insights", for: .normal)
            }
        case .age:
            self.categoryLabel.text = "Age"
            self.selectButton.setTitle(data, for: .normal)
        case .sex:
            self.categoryLabel.text = "Sex"
            self.selectButton.setTitle(data, for: .normal)
        case .height:
            self.categoryLabel.text = "Height"
            self.selectButton.setTitle(data, for: .normal)
        case .calorieIntake:
            self.categoryLabel.text = "Average Daily Calorie Intake"
            self.selectButton.setTitle(data, for: .normal)
        case .dailyActiveCalories:
            self.categoryLabel.text = "Daily Active Calories"
            self.selectButton.setTitle(data, for: .normal)
        case .averageBedTime:
            self.categoryLabel.text = "Average Bed Time"
            self.selectButton.setTitle(data, for: .normal)
        case .ideaBedTime:
            self.categoryLabel.text = "Idea Bed Time"
            self.selectButton.setTitle(data, for: .normal)
        case .averageWakeTime:
            self.categoryLabel.text = "Average Wake Time"
            self.selectButton.setTitle(data, for: .normal)
        case .dateOfExam:
            self.categoryLabel.text = "Date Of Exam"
            self.selectButton.setTitle(data, for: .normal)
        case .bloodPressureWithSystolic:
            self.categoryLabel.text = "Blood Pressure(systolic, mmHg)"
            self.selectButton.setTitle(data, for: .normal)
        case .bloodPressureWithDiastolic:
            self.categoryLabel.text = "Blood Pressure(diastolic, mmHg)"
            self.selectButton.setTitle(data, for: .normal)
        case .glucose:
            self.categoryLabel.text = "Glucose(mg/dL)"
            self.selectButton.setTitle(data, for: .normal)
        case .totalCholesterol:
            self.categoryLabel.text = "Total Cholesterol(mg/dL)"
            self.selectButton.setTitle(data, for: .normal)
        case .ldl:
            self.categoryLabel.text = "LDL(mg/dL)"
            self.selectButton.setTitle(data, for: .normal)
        case .weight:
            self.categoryLabel.text = "Weight"
            self.selectButton.setTitle(data, for: .normal)
        }
    }
}
