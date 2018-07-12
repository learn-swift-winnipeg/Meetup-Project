//
//  LoginService.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-07-08.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

class LogingManager: Logger {
    static let shared = LogingManager()
    
    func login(withUsername username: String, andPassword password: String) -> (success: Bool, message: String?, user: UserData?) {
        
        // TODO: - Replace this with backend enpoint
        let user = UserData(username: "user", password: "password", role: .admin)
        
        return (true, nil, user)
    }
}
