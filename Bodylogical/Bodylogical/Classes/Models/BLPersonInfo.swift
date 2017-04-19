//
//  BLPersonInfo.swift
//  Bodylogical
//
//  Created by appledev096 on 17/4/11.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import ObjectMapper

class BLAllPeople: Mappable {
    
    var allPeople: [BLPersonInfo]?
    required init?(map:Map) {
    }
    
    init() {
    }
    func mapping(map: Map) {
        allPeople <- map["allPeople"]
    }
}

class BLPersonInfo: Mappable {

    var firstName: String?
    var lastName: String?
    var imageData: Data?
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName  <- map["lastName"]
        imageData <- map["imageData"]
    }
 
}
