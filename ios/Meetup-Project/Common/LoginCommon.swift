//
//  LoginCommon.swift
//  MeetupProjectTests
//
//  Created by sebastien FOCK CHOW THO on 2018-07-09.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

enum UserRole: Int, Codable {
    case user
    case admin
}

struct UserData: Codable {
    let username: String
    let password: String
    let role: UserRole
}

protocol Logger {
    func login(withUsername username: String, andPassword password: String) -> (success: Bool, message: String?, user: UserData?)
}
