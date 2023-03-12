//
//  FightingSimulator2999UITests.swift
//  FightingSimulator2999UITests
//
//  Created by Teacher on 11.03.2023.
//

import XCTest

final class FightingSimulator2999UITests: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()
        app.launch()
        self.app = app
    }

    var app: XCUIApplication!

    func testResultViewControllerAppeared() throws {
        while (app.staticTexts["Magic attack"].exists) {
            XCUIApplication().staticTexts["Magic attack"].tap()
        }

        let button = app.buttons["Restart"].firstMatch

        _ = button.waitForExistence(timeout: 3)

        XCTAssertTrue(button.exists)

    }
}
