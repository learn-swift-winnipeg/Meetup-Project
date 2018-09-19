//
//  AuthRouteController.swift
//  App
//
//  Created by Steven Prichard on 8/19/18.
//

import Vapor


struct AuthRouteController : RouteCollection {
    private let authController = AuthController()
    
    func boot(router: Router) throws {
        router.get("auth/meetup/success", use: initAuthHandler)
    }
}

extension AuthRouteController {
    func initAuthHandler(_ req: Request) throws -> Future<Response>{
        let code = try req.query.get(String.self, at: "code")
        // Get Access Information
        return try self.authController.authContainer(for: code, req: req).flatMap({ authContainer in
            // Use Access Information to get Meetup User Information
            return try self.authController.authContainer(for: authContainer, req: req).flatMap({ meetupUser in
                // Create User object
                let user = User(name: meetupUser.name,
                                email: meetupUser.email,
                                accessToken: authContainer.access_token,
                                refreshToken: authContainer.refresh_token)
                // We don't want to send this information to the frontend becuase it contains the Users tokens
                user.save(on: req)
                return try ResponseJSON<MeetupUser>(data: meetupUser).encode(for: req)
            })
        })
    }
}

