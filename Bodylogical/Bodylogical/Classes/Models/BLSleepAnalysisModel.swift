//
//  BLSleepAnalysisModel.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/21.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import ObjectMapper

class BLSleepAnalysisModel: Mappable {

    var averageBedTime: String?
    var ideaBedTime: String?
    var averageWakeTime: String?
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        averageBedTime  <- map["averageBedTime"]
        ideaBedTime     <- map["ideaBedTime"]
        averageWakeTime <- map["averageWakeTime"]
    }
    
}
