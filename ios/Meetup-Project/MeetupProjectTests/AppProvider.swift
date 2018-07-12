//
//  AppProvider.swift
//  MeetupProjectTests
//
//  Created by sebastien FOCK CHOW THO on 2018-07-11.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

class AppProvider {
    static let shared = AppProvider()
    
    var loginManager: Logger!
    
    init() {
        loginManager = MockLoginManager()
    }
}
