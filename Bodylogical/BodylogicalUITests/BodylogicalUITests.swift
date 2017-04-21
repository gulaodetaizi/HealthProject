//
//  BodylogicalUITests.swift
//  BodylogicalUITests
//
//  Created by appledev096 on 17/4/19.
//  Copyright © 2017年 Person. All rights reserved.
//

import XCTest

class BodylogicalUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let emailAddressTextField = tablesQuery.textFields["Email address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("taixiu.zhang@gmail.com")
       
        let clearTextSecureTextField = tablesQuery.secureTextFields["Email password"]
        clearTextSecureTextField.tap()
        clearTextSecureTextField.typeText("123456Qqw")
        tablesQuery.children(matching: .cell).element(boundBy: 0).tap()
      
        tablesQuery.buttons["Create an account"].tap()
        
        
        tablesQuery.textFields["Email address"].tap()
        
        let textField = tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element
        textField.typeText("taixiu.zhang@gmail.com")
        
        let deleteKey = app.keys["delete"]
        deleteKey.tap()
        deleteKey.tap()
        let moreKey = app.keys["more"]
        moreKey.tap()
        moreKey.tap()
        textField.typeText("om")

        tablesQuery.textFields["Enter password"].tap()
        moreKey.tap()
        
        let textField2 = tablesQuery.children(matching: .cell).element(boundBy: 2).children(matching: .textField).element
        textField2.typeText("123456")
        app.buttons["shift"].tap()
        textField2.typeText("Qq")
        XCUIDevice.shared().orientation = .portrait
        textField2.typeText("w")
        textField2.tap()
        
        tablesQuery.textFields["Re-enter password"].tap()
        moreKey.tap()
        let textField3 = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element
        textField3.typeText("123456")
        textField3.typeText("Qqw")
        tablesQuery.textFields["Zip code"].tap()
        moreKey.tap()
        
        let textField4 = tablesQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textField).element
        textField4.typeText("1")
        textField4.typeText("234567890")
        
        let ReEnterDeleteKey = app.keys["delete"]
        ReEnterDeleteKey.tap()
        ReEnterDeleteKey.tap()
        ReEnterDeleteKey.tap()
        ReEnterDeleteKey.tap()
        textField4.typeText("123445")
        
        textField3.tap()
        tablesQuery.buttons["Create account"].tap()
        
        tablesQuery.buttons["Connect to Apple Health"].tap()
        tablesQuery.staticTexts["Sex"].swipeRight()
        tablesQuery.staticTexts["Blood Pressure(systolic, mmHg)"].tap()
        
        let button = tablesQuery.buttons["2017-04-20"]
        button.tap()
        button.tap()
        app.navigationBars["Health Access"].buttons["Done"].tap()
        XCUIDevice.shared().orientation = .faceUp
        
        let table = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.tap()
        table.tap()
        table.tap()
        table.tap()
        
    }
    
}
