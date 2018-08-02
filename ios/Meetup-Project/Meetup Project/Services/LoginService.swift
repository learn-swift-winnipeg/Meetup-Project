//
//  LoginService.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-07-08.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import OAuthSwift
import SafariServices

class LogingManager: Logger {
    static let shared = LogingManager()
    
    func login(withUsername username: String, andPassword password: String) -> (success: Bool, message: String?, user: UserData?) {
        
        // TODO: - Replace this with backend enpoint
        let user = UserData(username: "user", password: "password", role: .admin)
        
        return (true, nil, user)
    }
    
    func oauth2Login(_ controller: UIViewController) {
        let oauthswift = OAuth2Swift(
            consumerKey   : OAuthConstants.key,
            consumerSecret: OAuthConstants.secret,
            authorizeUrl  : OAuthConstants.authorizationEndpoint,
            accessTokenUrl: OAuthConstants.accessTokenEndpoint,
            responseType  : OAuthConstants.responseType
        )
        
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: controller, oauthSwift: oauthswift)
        
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: OAuthConstants.redirectUri)!,
            scope: OAuthConstants.scope,
            state: OAuthConstants.state,
            success: { credential, response, parameters in
                print("success")
                UserDefaults.standard.set(credential.oauthToken, forKey: OAuthConstants.meetupAccessToken)
                UserDefaults.standard.synchronize()
                
            },
            failure: { error in
                print("error")
                print(error.localizedDescription)
            }
        )
    }
    
    func oauth2Logout() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}
