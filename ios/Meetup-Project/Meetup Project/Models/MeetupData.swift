//
//  MeetupData.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-08-03.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

enum MeetupStatus: String {
    case active
    case inactive
}

struct MeetupData {
    var id: Int
    var name: String
    var status: MeetupStatus
    
    static func fromJson(_ json: [String : Any]) -> MeetupData? {
        guard let id = json["id"] as? Int
            , let name = json["name"] as? String
            , let status = json["status"] as? String else {
                return nil
        }
        
        return MeetupData(id: id, name: name, status: (status == "active" ? .active : .inactive))
    }
}
