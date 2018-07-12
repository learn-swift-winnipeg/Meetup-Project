//
//  MockLoginManager.swift
//  MeetupProjectTests
//
//  Created by sebastien FOCK CHOW THO on 2018-07-08.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

class MockLoginManager: Logger {
    static let shared = MockLoginManager()
    
    func login(withUsername username: String, andPassword password: String) -> (success: Bool, message: String?, user: UserData?) {
        
        if username == "user" && password == "password" {
            let user = UserData(username: "user", password: "password", role: .admin)
            
            return (true, nil, user)
        } else {
            return (false, "Random error message", nil)
        }
    }
}
