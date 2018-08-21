//
//  User.swift
//  App
//
//  Created by Steven Prichard on 8/11/18.
//

import Vapor
import FluentMySQL


// TODO: User needs to conform to PasswordAuthenticatable
// https://medium.com/@martinlasek/tutorial-how-to-build-web-auth-with-session-f9f64ba49830

final class User: Codable {
    var id: Int?
    var firstName: String
    var lastName: String
    var accessToken: String?
    var refreshToken: String?
    var email: String?
    
    // TODO: Complete fill out the required information for a User
    
    init(name: String, email: String, accessToken: String, refreshToken: String) {
        let info = name.split(separator: " ")
        self.firstName = String(info[0])
        self.lastName = String(info[1])
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.email = email
    }
}

extension User: MySQLModel{}
extension User: Migration{}
extension User: Content{}

struct MeetupUser: Content {
    var id: Int
    var name: String
    var email: String
    
    // TODO: Get User Photo
}
