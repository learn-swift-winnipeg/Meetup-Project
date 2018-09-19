//
//  Meetup.swift
//  App
//
//  Created by Steven Prichard on 8/14/18.
//

import Foundation
import Vapor
import Authentication

class MeetupAPI {
    var accessToken: String
    var headers: HTTPHeaders

    init(accessToken: String) {
        self.accessToken = accessToken
        
        // Setup Autherization Header
        var headers = HTTPHeaders()
        headers.bearerAuthorization = BearerAuthorization(token: self.accessToken)
        self.headers = headers
    }
    
    static func setConfig() -> AccessHeaders {
        let cID = Environment.get("MEETUP_CLIENT_ID")
        guard let clientID = cID else {
            fatalError("Missing Client ID")
        }
        
        let cS = Environment.get("MEETUP_CLIENT_SECRET")
        guard let clientSecret = cS else {
            fatalError("Missing Client Secret")
        }
        
        let mGT = Environment.get("MEETUP_GRANT_TYPE")
        guard let grantType = mGT else {
            fatalError("Missing Grant Type")
        }
        
        let rUIR = Environment.get("MEETUP_REDIRECT_URI")
        guard let redirectURI = rUIR else {
            fatalError("Missing Redirect URI")
        }
        
        let h = Environment.get("HOST")
        guard let host = h else {
            fatalError("Missing Host")
        }
        
        let p = Environment.get("PORT")
        guard let port = p else {
            fatalError("Missing Port")
        }
        // Construct the redirect URI
        let uri = "\(host):\(port)"
        let redirect = uri + redirectURI
        
        return AccessHeaders(client_id: clientID, client_secret: clientSecret, grant_type: grantType, redirect_uri: redirect, code: "")
    }
    
    // MARK: - Fetchers
    
    func getUserInformation(request: Request) throws -> Future<MeetupUser> {
        return try request.client()
            .get("https://api.meetup.com/members/self", headers: self.headers)
            .map(to: MeetupUser.self) { response in
                switch response.http.status {
                case .ok:
                    return try response.content.syncDecode(MeetupUser.self)
                case .unauthorized:
                    // TODO: /auth/failure isn't defined, define it
                    throw Abort.redirect(to: "/auth/failure")
                default:
                    throw Abort(.internalServerError)
                }
            }
        }
        
    static func getAccessInformation(request: Request, code: String) throws -> Future<AuthContainer> {
        let accessRequest = HTTPRequest(method: .POST,
                                        url: "https://secure.meetup.com/oauth2/access",
                                        body: "")
        
        let client = try request.make(Client.self)
        let req = Request(http: accessRequest, using: client.container)
        var accessHeaders = self.setConfig()
        accessHeaders.code = code
        
        try req.content.encode(accessHeaders, as: .urlEncodedForm)
        
        return client.send(req)
            .map(to: AuthContainer.self, { response in
                switch response.http.status {
                case .ok:
                    return try response.content.syncDecode(AuthContainer.self)
                case .unauthorized:
                    // TODO: /auth/failure isn't defined, define it
                    throw Abort.redirect(to: "/auth/failure")
                default:
                    throw Abort(.internalServerError)
                }
        })
    }
    
    
}













