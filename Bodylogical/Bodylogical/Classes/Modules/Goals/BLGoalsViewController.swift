//
//  BLGoalsViewController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/19.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class BLGoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var adbk : ABAddressBook!
    var allPeople: [BLPersonInfo]?

    @IBOutlet weak var tableView: UITableView!
    var peopleCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "John Smith Summary"
        self.view.backgroundColor = UIColor.green
        loadPerson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCells() {
        tableView.registerNibWithCell(BLAddressBookCell.self)
    }
    
    func loadPerson() {
        
        let addressBookRef = ABAddressBookCreateWithOptions(nil, nil)
        
        switch ABAddressBookGetAuthorizationStatus() {
        case .notDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBookRef as ABAddressBook!, { (granted, error) in

                var error1 : Unmanaged<CFError>? = nil
                let addressBook = ABAddressBookCreateWithOptions(nil, &error1).takeRetainedValue()
                self.copyAddressBook(addressBook: addressBook)
                
            })
        case .authorized:

            var error : Unmanaged<CFError>? = nil
            let addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
            self.copyAddressBook(addressBook: addressBook)
        default:
            print("没有获取通讯录权限")
        }
    }
    
    func createAddressBook() -> Bool {
        if self.adbk != nil {
            return true
        }
        var err : Unmanaged<CFError>? = nil
        let adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
        if adbk == nil {
            self.adbk = nil
            return false
        }
        self.adbk = adbk
        return true
    }
    
    func copyAddressBook(addressBook: ABAddressBook) {
//        peopleCount = ABAddressBookGetPersonCount(addressBook).
//        let people = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as [ABRecord]
//        allPeople = [BLPersonInfo]()
//        
//        for person in people {
//            let personInfo = BLPersonInfo()
//            
//            let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue()
//            let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue()
//            let headPhotoData = ABPersonCopyImageData(person)?.takeRetainedValue() as? Data
//            personInfo.imageData = headPhotoData
//            personInfo.firstName = firstName as! String?
//            personInfo.lastName = lastName as! String?
//            allPeople?.append(personInfo)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(BLAddressBookCell.self)
        return cell
    }
}
