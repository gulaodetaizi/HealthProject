//
//  BLProfileViewController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/19.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI


class BLProfileViewController: UIViewController,ABPeoplePickerNavigationControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "John Smith Summary"
        self.view.backgroundColor = UIColor.purple
    }
    @IBAction func selectPerson(_ sender: UIButton) {
        let peopleNav = ABPeoplePickerNavigationController()
        peopleNav.peoplePickerDelegate = self
        peopleNav.predicateForSelectionOfPerson = NSPredicate(value: false)
        self.navigationController?.present(peopleNav, animated: true, completion: { 
            
        })
    }
    
    func peoplePickerNavigationControllerDidCancel(_ peoplePicker: ABPeoplePickerNavigationController) {
        peoplePicker.dismiss(animated: true) {
        }
    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        
        let personVC = ABPersonViewController()
        personVC.displayedPerson = person
        peoplePicker.pushViewController(personVC, animated: true)
        
        print("ABRecord = \(person)")
        
        
        
    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        let phone = ABRecordCopyValue(person, kABPersonPhoneProperty)?.takeRetainedValue()
        let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
        let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String
        
        let index = ABMultiValueGetIndexForIdentifier(phone, identifier)
        let number = ABMultiValueCopyValueAtIndex(phone, index)?.takeRetainedValue()
        numberLabel.text = number as? String
        nameLabel.text = (firstName ?? "") + (lastName ?? "")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
