//
//  OnlineShopUITests.swift
//  OnlineShopUITests
//
//  Created by Teacher on 25.02.2023.
//

import XCTest

final class OnlineShopUITests: XCTestCase {
    override func setUp() {
        let app = XCUIApplication()
        app.launch()
        self.app = app
    }

    var app: XCUIApplication!

    func testWrongLoginPassword() throws {
        let loginField = app.textFields["LoginTextField"].firstMatch
        let passwordField = app.textFields["PasswordTextField"].firstMatch
        let signInButton = app.buttons["LogInButton"].firstMatch

        loginField.tap()
        loginField.typeText("123")
        passwordField.tap()
        passwordField.typeText("123")
        signInButton.tap()

        let alert = app.alerts["OOOPS"].firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
    }

    func testCustomTest() {
        let app = XCUIApplication()
        let loginfieldTextField = app.textFields["LoginTextField"]
        loginfieldTextField.tap()

        let passwordTextField = app.textFields["PasswordTextField"]
        passwordTextField.tap()
        app.buttons["LogInButton"].tap()
        let alert = app.alerts["OOOPS"]
        _ = alert.waitForExistence(timeout: 1)
        alert.buttons["OK"].tap()

        XCTAssertFalse(alert.exists)
    }

    func testRightLoginPassword() {
        let loginField = app.textFields["LoginTextField"].firstMatch
        let passwordField = app.textFields["PasswordTextField"].firstMatch
        let signInButton = app.buttons["LogInButton"].firstMatch

        loginField.tap()
        loginField.typeText("admin")
        passwordField.tap()
        passwordField.typeText("qwerty")
        signInButton.tap()

        let label = app.staticTexts["Catalog"]

        _ = label.waitForExistence(timeout: 3)
        XCTAssertTrue(label.exists)
    }

    func testLogOut() {
        let loginField = app.textFields["LoginTextField"].firstMatch
        let passwordField = app.textFields["PasswordTextField"].firstMatch
        let signInButton = app.buttons["LogInButton"].firstMatch

        loginField.tap()
        loginField.typeText("admin")
        passwordField.tap()
        passwordField.typeText("qwerty")
        signInButton.tap()


        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        app.staticTexts["Sign out"].tap()


        let button = app.buttons["LogInButton"].firstMatch

        _ = button.waitForExistence(timeout: 3)
        XCTAssertTrue(button.exists)
    }
}
