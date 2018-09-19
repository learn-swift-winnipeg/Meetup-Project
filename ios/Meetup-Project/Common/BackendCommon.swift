//
//  BackendCommon.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-09-18.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

struct ChatData: Codable {
    let body: String
    let user: UserData
    let time: Date
}

protocol BackendProvider {
    func retrieveChat(forMeetup: MeetupData) -> [ChatData]
}
