//
//  AppProvider.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-07-08.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

class AppProvider {
    static let shared = AppProvider()
    
    var loginManager: Logger!
    var meetupApi: MeetupAPI!
    var backend: BackendProvider!
    
    init() {
        #if debug
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            loginManager = MockLoginManager()
        }
        backend = MeetupProjectAPI.shared
        #else
        loginManager = LogingManager.shared
        meetupApi = MeetupAPI.shared
        backend = MeetupProjectAPI.shared
        #endif
    }
}
