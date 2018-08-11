//
//  User.swift
//  App
//
//  Created by Steven Prichard on 8/11/18.
//

import Vapor
import FluentMySQL

final class User: Codable {
    var id: Int?
    var firstName: String
    var lastName: String
    var accessToken: String?
    var refreshToken: String?
    
    // TODO: Complete fill out the required information for a User
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension User: MySQLModel{}
extension User: Migration{}
extension User: Content{}
