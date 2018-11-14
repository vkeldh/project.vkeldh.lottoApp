//
//  lottoAppUITests.swift
//  lottoAppUITests
//
//  Created by padio on 2018. 4. 13..
//  Copyright © 2018년 padio. All rights reserved.
//

import XCTest

var app = XCUIApplication()

class lottoAppUITests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
      
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
    }
    
    func testEXGO(){
        
       
        let searchbtn = app.buttons["번호찾기"]
        
        searchbtn.tap()
        
       /* let newBtn = app.buttons["새번호"]
        newBtn.tap()
        */
        let labelText = app.staticTexts["lumber_1"]
        XCTAssertTrue(labelText.exists)
        
        let predicate = NSPredicate(format: "exists == true")
        let promise = expectation(for: predicate,
                                  evaluatedWith: labelText,
                                  handler: nil)
        wait(for: [promise], timeout: 1)
        
    }
    func testRepet(){
        
   
        
        
    }
    
}
