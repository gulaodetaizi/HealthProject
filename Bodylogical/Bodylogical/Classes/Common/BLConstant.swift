//
//  BLConstant.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/18.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Font
let FONT_NORMAL12 = UIFont(name: "Helvetica Neue", size: 12)
let FONT_NORMAL13 = UIFont(name: "Helvetica Neue", size: 13)
let FONT_NORMAL14 = UIFont(name: "Helvetica Neue", size: 14)
let FONT_NORMAL15 = UIFont(name: "Helvetica Neue", size: 15)
let FONT_NORMAL16 = UIFont(name: "Helvetica Neue", size: 16)
let FONT_NORMAL17 = UIFont(name: "Helvetica Neue", size: 17)

let FONT_MEDIUM14 = UIFont(name: "HelveticaNeue-Medium", size: 14)
let FONT_MEDIUM16 = UIFont(name: "HelveticaNeue-Medium", size: 16)
let FONT_MEDIUM17 = UIFont(name: "HelveticaNeue-Medium", size: 17)
let FONT_MEDIUM22 = UIFont(name: "Helvetica Neue Medium", size: 22)

let FONT_BOLD13 = UIFont(name: "HelveticaNeue-Bold", size: 13)
let FONT_BOLD14 = UIFont(name: "HelveticaNeue-Bold", size: 14)
let FONT_BOLD15 = UIFont(name: "HelveticaNeue-Bold", size: 15)
let FONT_BOLD16 = UIFont(name: "HelveticaNeue-Bold", size: 16)
let FONT_BOLD17 = UIFont(name: "HelveticaNeue-Bold", size: 17)

enum BLPageType {
    case connectApple
    case healthAccess
}

enum BLPersonalDataType {
    case desiredInsights
    case age
    case sex
    case height
    
    case calorieIntake
    case dailyActiveCalories
    case averageBedTime
    case ideaBedTime
    case averageWakeTime
    
    case dateOfExam
    case bloodPressureWithSystolic
    case bloodPressureWithDiastolic
    case glucose
    case totalCholesterol
    case ldl
    case weight
    
}

enum BLSleepType {
    case bedTime
    case inBed
    case awakeBed
}

enum BLQuantityType {
    
    case basalEnergyBurned
    case activeEnergyBurned
}
