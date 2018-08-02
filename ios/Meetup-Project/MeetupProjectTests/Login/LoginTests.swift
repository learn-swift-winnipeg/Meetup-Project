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
    
    func testOAuth2LoginSuccess() {
        let _ = appProvider.loginManager.oauth2Login(UIViewController())
        
        XCTAssert(UserDefaults.standard.string(forKey: OAuthConstants.meetupAccessToken) == "THIS-IS-YOUR-TOKEN")
    }
    
    func testOAuth2LogoutSuccess() {
        let _ = appProvider.loginManager.oauth2Logout()
        
        XCTAssertNil(UserDefaults.standard.string(forKey: OAuthConstants.meetupAccessToken))
    }
    
}
