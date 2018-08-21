//
//  ResponseJSON.swift
//  App
//
//  Created by Steven Prichard on 8/19/18.
//
import Vapor

struct Empty: Content {}

struct ResponseJSON<T: Content> : Content {
    private var status: ResponseStatus
    private var message: String
    private var data: T?
    
    init(status: ResponseStatus = .ok){
        self.status = status
        self.message = status.desc
        self.data = nil
    }
    
    init(data: T) {
        self.status = .ok
        self.message = self.status.desc
        self.data = data
    }
}


enum ResponseStatus: Int, Content {
    case ok = 0
    case error = 1
    
    var desc : String {
        switch self {
        case .ok:
            return "Request Succuessful"
        case .error:
            return "Request Failed"
        }
    }
    
}
