//
//  Meetup.swift
//  App
//
//  Created by Steven Prichard on 8/19/18.
//

import Foundation
import Vapor


struct AuthController {
    // create func for authcontiner given a thing
    // might want to create a type alias for code -> string
    func authContainer(for accessCode: String, req: Request) throws -> Future<AuthContainer>{
        return try MeetupAPI.getAccessInformation(request: req, code: accessCode)
            .map({ auth in return auth })
    }
    
    func authContainer(for authContainer: AuthContainer, req: Request) throws -> Future<MeetupUser> {
        let api = MeetupAPI(accessToken: authContainer.access_token)
        return try api.getUserInformation(request: req)
    }
    
    func authContainer(for meetupUser: MeetupUser, with auth: AuthContainer, req: Request) throws -> Future<User> {
        // create User
        let user = User(name: meetupUser.name,
                        email: meetupUser.email,
                        accessToken: auth.access_token,
                        refreshToken: auth.refresh_token)
        
        // return saved User
        return user.save(on: req)
    }

}
