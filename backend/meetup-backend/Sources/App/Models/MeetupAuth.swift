//
//  Auth.swift
//  App
//
//  Created by Steven Prichard on 8/15/18.
//
import Vapor

struct AuthContainer: Content {
    var access_token: String
    var refresh_token: String
    var expires_in: TimeInterval
}

struct AccessHeaders: Encodable {
    var client_id: String
    var client_secret: String
    var grant_type: String
    var redirect_uri: String
    var code: String
}
