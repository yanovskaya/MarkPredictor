//
//  MarkPredictorUITests.swift
//  MarkPredictorUITests
//
//  Created by Елена Яновская on 05.05.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import XCTest

class MarkPredictorUITests: XCTestCase {
    
    private var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialStateIsCorrect() {
        let labels = XCUIApplication().staticTexts
        XCTAssertEqual(labels.count, 14)
    }
    
}
