//
//  LoginTests.swift
//  MeetupProjectTests
//
//  Created by sebastien FOCK CHOW THO on 2018-07-09.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {
    
    var appProvider: AppProvider!
    
    override func setUp() {
        super.setUp()
        
        appProvider = AppProvider.shared
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let loginResult = appProvider.loginManager.login(withUsername: "user", andPassword: "password")
        
        XCTAssert(loginResult.success == true)
    }
    
    func testLoginFailure() {
        let loginResult = appProvider.loginManager.login(withUsername: "wrongUser", andPassword: "wrongPassword")
        
        XCTAssert(loginResult.success == false)
    }
    
}
