//
//  BLHealthKitManager.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/18.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import HealthKit

class BLHealthKitManager: NSObject {
    
    var completionHandler: ((Bool, NSError)-> ())?
    
    let healthKitStore: HKHealthStore = HKHealthStore()

    class var sharedInstance: BLHealthKitManager {
        struct Static {
             static var instance: BLHealthKitManager = BLHealthKitManager()
        }
    
        return Static.instance
    }
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        // State the health data type(s) we want to write from HealthKit.
        let writeDataTypes: Set<HKSampleType> = self.dataTypesToWrite()
        // State the health data type(s) we want to read from HealthKit.
        let readDataTypes: Set<HKObjectType> = self.dataTypesToRead()
        
        // Request authorization to read and/or write the specific data.
        healthKitStore.requestAuthorization(toShare: writeDataTypes, read: readDataTypes) { (success, error) in
            completion(success, error)
        }
    }
    
    func dataTypesToWrite() -> Set<HKSampleType> {
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        
        let dietaryCalorieEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let activeEnergyBurnType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        let writeDataTypes: Set<HKSampleType> = [ heightType, dietaryCalorieEnergyType, activeEnergyBurnType, weightType]
        
        return writeDataTypes
    }
    
    func dataTypesToRead() -> Set<HKObjectType> {
        
        let birthdayType = HKQuantityType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!
        let biologicalSexType = HKQuantityType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        
        let dietaryCalorieEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!

        let activeEnergyBurnType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
     
        let calorieIntakeType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)!
        let activeCalorieType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let sleepType = HKQuantityType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        
        let bloodPressureSysolic = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
        let bloodPressureDiastolic = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!
        let bloodGlucose = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!
        let totalCholesterol = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        let readDataTypes: Set<HKObjectType> = [birthdayType, biologicalSexType, heightType, dietaryCalorieEnergyType, activeEnergyBurnType, calorieIntakeType, activeCalorieType, sleepType, bloodPressureSysolic, bloodPressureDiastolic, bloodGlucose, totalCholesterol, weightType]
        
        
        return readDataTypes
    }
    
    func getUserAge() -> String {
        var dateOfBirth: Date! = nil
        
        do {
            
            dateOfBirth = try self.healthKitStore.dateOfBirth()
            
        } catch {
            
            print("Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.")
            
            return ""
        }
        
        let now = Date()
        
        let ageComponents: DateComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: now)
        
        let userAge: Int = ageComponents.year!
        
        let ageValue: String = NumberFormatter.localizedString(from: userAge as NSNumber, number: NumberFormatter.Style.none)
        
        return ageValue
    }
    
    func getUserSex() -> String {
        do {
            let sexObject = try self.healthKitStore.biologicalSex()
            switch sexObject.biologicalSex {
            case .female:
                return "female"
            case .male:
                return "male"
            default:
                return "not set sex"
            }
        } catch {
            return "not set sex"
        }
    }
    
    func getUserHeight(completion:@escaping ((String?, Error?) ->())) {
        var quantity:HKQuantity?
        let sampleType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        let timeSortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let heightQuery  = HKSampleQuery(sampleType: sampleType! , predicate: nil, limit: 1, sortDescriptors: [timeSortDescriptor]) { (query, results, error) in
            let sample = results?.last as? HKQuantitySample
            quantity = sample?.quantity
            let height = NSNumber(value: (quantity?.doubleValue(for: HKUnit.meter()))!).stringValue
            completion(height,error)
        }
        self.healthKitStore.execute(heightQuery)
    }
    
    func getBedTimeBySleepType(completion:((_ value:BLSleepAnalysisModel?, Error?) ->())!) {
        let categoryType = HKQuantityType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)
        let sortDescriper = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: categoryType!, predicate: nil, limit: 30, sortDescriptors: [sortDescriper]) { (sampleType, results, error) in
            if results != nil {
                    // do something with my data
                let sleepAnalysis = BLSleepAnalysisModel()
                    for item in results! {
                        if let sample = item as? HKCategorySample {
                            if #available(iOS 10.0, *) {
                                switch sample.value {
                                case HKCategoryValueSleepAnalysis.asleep.rawValue:
                                    let time = sample.endDate.timeIntervalSince(sample.startDate)/3600
                                    sleepAnalysis.averageBedTime = String(time)
                                case HKCategoryValueSleepAnalysis.inBed.rawValue:
                                    let time = sample.endDate.timeIntervalSince(sample.startDate)/3600
                                    sleepAnalysis.ideaBedTime = String(time)
                                case HKCategoryValueSleepAnalysis.awake.rawValue:
                                    let time = sample.endDate.timeIntervalSince(sample.startDate)/3600
                                    sleepAnalysis.averageWakeTime = String(time)
                                default:
                                    break
                                }
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                    }
                    completion(sleepAnalysis, error)
                }
            
        }
        self.healthKitStore.execute(query)
    }
    
    func getQuantityTypeDataByIdentifier(identifier: HKQuantityTypeIdentifier, completion:@escaping ((HKQuantity?, Error?) ->())) {
        var quantity:HKQuantity?
        let  sampleType = HKQuantityType.quantityType(forIdentifier: identifier)
        
        let startDate = Date.distantPast
        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions())
        let timeSortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let heightQuery  = HKSampleQuery(sampleType: sampleType! , predicate: predicate, limit: 30, sortDescriptors: [timeSortDescriptor]) { (query, results, error) in
            let sample = results?.first as? HKQuantitySample
            quantity = sample?.quantity
            completion(quantity,error)
        }
        self.healthKitStore.execute(heightQuery)
    }
    
    func saveDistance(distanceRecorded: Double, date: Date) {
        
        // Set the quantity type to the running/walking distance.
        let distanceType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        
        // Set the unit of measurement to miles.
        let distanceQuantity = HKQuantity(unit: HKUnit.mile(), doubleValue: distanceRecorded)
        
        // Set the official Quantity Sample.
        let distance = HKQuantitySample(type: distanceType!, quantity: distanceQuantity, start: date as Date, end: date as Date)
        
        // Save the distance quantity sample to the HealthKit Store.
        healthKitStore.save(distance, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error!.localizedDescription)
            } else {
                print("The distance has been recorded! Better go check!")
            }
        })
    }
}
