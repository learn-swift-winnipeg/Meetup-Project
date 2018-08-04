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

enum MeetupResult {
    case success([MeetupData])
    case failure(String)
}

class MeetupAPI {
    static let shared = MeetupAPI()
    
    var urlComponents = URLComponents()
    
    private init() {
        urlComponents.scheme = "https"
        urlComponents.host = "api.meetup.com"
    }
    
    func retrieveMeetups(completion: @escaping (MeetupResult) -> Void) {
        
        urlComponents.path = "/self/groups"
        
        var queryItems = [URLQueryItem]()
        queryItems.append(
            URLQueryItem(
                name: "access_token",
                value: UserDefaults.standard.string(forKey: OAuthConstants.meetupAccessToken)
            )
        )
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(MeetupResult.failure("Error while retrieving meetups"))
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                return completion(MeetupResult.failure("\(httpStatus.statusCode) Error"))
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                    return completion(MeetupResult.failure("Could not convert response to json"))
                }
                
                var meetups: [MeetupData] = []
                
                for object in json {
                    if let meetup = MeetupData.fromJson(object) {
                        meetups.append(meetup)
                    }
                }
                
                return completion(MeetupResult.success(meetups))
            } catch {
                completion(MeetupResult.failure("Error: \(error)"))
            }
        }
        task.resume()
    }
}
