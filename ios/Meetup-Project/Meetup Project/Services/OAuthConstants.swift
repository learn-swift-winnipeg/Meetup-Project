//
//  OAuthConstants.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-08-01.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

struct OAuthConstants {
    // TODO: - Setup your OAuth consumer here: https://secure.meetup.com/meetup_api/oauth_consumers/
    // And replace key, secret
    
    // consumer name: swiftWinnipegMeetupProject
    // app website: https://www.meetup.com/learn-swift-winnipeg/
    // redirect uri: meetupProject://com.sfct.meetupproject
    
    static let key                     = "<your-key>"
    static let secret                  = "<your-secret>"
    static let redirectUri             = "meetupProject://com.sfct.meetupproject"
    static let authorizationEndpoint   = "https://secure.meetup.com/oauth2/authorize"
    static let accessTokenEndpoint     = "https://secure.meetup.com/oauth2/access"
    static let responseType            = "code"
    static let state                   = "meetup\(Int(Date().timeIntervalSince1970))"
    static let scope                   = "ageless"
    static let meetupAccessToken       = "meetupAccessToken"
}
