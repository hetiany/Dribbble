//
//  AccountManager.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/18/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation


protocol AccountManagerDelegate: class {
    func didFinishOAuthFlow(success: Bool, error: Error?)
}


class AccountManager {
    static let shared = AccountManager()
    private init() {
        
    }
    struct Keys {
        static let requestTokenURL = "https://dribbble.com/oauth/token"
        static let oauthLoginURL = "https://dribbble.com/oauth/authorize"
        static let scope = "public+write"
        static let scopePermission = "public write"
        static let bearer = "bearer"
        static let callBackUrl = "driapicallback"
        
        static let clientId = "c5f84baa3d4096f07768beb612f28203962046bf12671823c2b3da8c6cfbed8a"
        static let clientSecret = "304dd3befbaa17e3e374d1ea01213c95491fdc91b4389a17ddd801c4a417ef08"
        //static let publicToken = "a156d6134f4a70f744b0215d74890e0f38e9c60f1d08a80e5c69c900a8aa006f"
        
        static let kUserDefaultAccessToken = "kUserDefaultAccessToken"
    }
    
    fileprivate let userDefault = UserDefaults.standard

    private(set) var accessToken: String? {
        get {
            return userDefault.object(forKey: Keys.kUserDefaultAccessToken) as? String
        }
        set {
            userDefault.set(newValue, forKey: Keys.kUserDefaultAccessToken)
        }
    }
    fileprivate var createdAt: Int?
    fileprivate var isRequesting = false
    
    weak var delegate: AccountManagerDelegate?
    
    var hasAccessToken: Bool {
        if accessToken != nil {
            return true
        }
        return false
    }
    
    var isRequestingOAuth: Bool {
        return isRequesting
    }
    
    func clearRequestingOAuth() {
        isRequesting = false
    }
    
    func resetAccessToken(to str: String?) {
        self.accessToken = str
    }
    
    // sept1: create url for OAUth2
    var oauth2LoginUrl: URL? {
        
        let oauthLoginURL = Keys.oauthLoginURL
        let clientId = Keys.clientId
        let scope = Keys.scope
        
        let authPath = "\(oauthLoginURL)?client_id=\(clientId)&scope=\(scope)"
        guard let authUrl = URL(string: authPath) else {
            assertionFailure("Invalid authPath to URL")
            return  nil
        }
        return authUrl
    }
    
    // sept2: login with login url
    func handleCallBack(url: URL) {
        if isRequesting {
            return
        }
        isRequesting = true
        
        processOAuthCallBack(url: url) { [weak self] (success, error) in
            self?.delegate?.didFinishOAuthFlow(success: success, error: error)
        }
    }
    
    
    private func processOAuthCallBack(url: URL, completion: @escaping (Bool, Error?) -> ()) {
        
        guard let code = parseCode(from: url) else {
            completion(false, nil)
            return
        }
        requestToken(code: code) { [weak self] (success, error) in
            self?.isRequesting = false
            completion(success, error)
        }
    }
    
    
    private func parseCode(from url: URL) -> String? {
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        var code: String?
        guard let queryItems = components?.queryItems else {
            return nil
        }
        for queryItem in queryItems {
            if queryItem.name.lowercased() == "code" {
                code = queryItem.value
                break
            }
        }
        return code
    }
    
    private func requestToken(code: String, completion: @escaping (Bool, Error?) -> ()) {
        let params = [
            "client_id" : Keys.clientId,
            "client_secret" : Keys.clientSecret,
            "code" : code
        ]
        let header = ["Authorization": "appplication/json"]
        
        
        HTTPTools.post(urlStr: Keys.requestTokenURL, parameters: params, header: header) { [weak self] (result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            self?.parseAccessToken(object: result, completion: completion)
            
        }
    }
    
    private func parseAccessToken(object: String?, completion: @escaping (Bool, Error?) -> ()) {
        
        guard let object = object else {
            assertionFailure("Invalid response json")
            completion(false, nil)
            return
        }
        
//        guard let jsonDict = object as? [String: Any] else {
//            assertionFailure("Invalid response json format")
//            completion(false, nil)
//            return
//        }
        
        guard let jsonData = object.data(using: .utf8, allowLossyConversion: false) else {
            assertionFailure("object cannot decode")
            completion(false, nil)
            return
        }
        
        guard let jsonDict = (try? JSONSerialization.jsonObject(with: jsonData, options: [])) as? [String: Any] else {
            assertionFailure("Invalid respinse json ormat")
            completion(false, nil)
            return
        }
        
        var accessToken: String?
        var createdAt: Int?
        var scope: String = ""
        var type: String = ""
        
        for (key, value) in jsonDict {
            switch key {
            case "access_token":
                accessToken = value as? String
            case "scope":
                scope = (value as? String) ?? ""
            case "token_type":
                type = (value as? String) ?? ""
            case "created_at":
                createdAt = value as? Int
            default:
                print("More key value pair: \(key) - \(value)")
            }
        }
        
        guard scope == Keys.scopePermission, type == Keys.bearer else {
            assertionFailure("Cannot find valid auth permission")
            completion(false, nil)
            return
        }
        
        guard let validAccessToken = accessToken, let validCreatedAt = createdAt else {
            assertionFailure("Cannot find valid accessToken")
            completion(false, nil)
            return
        }
        
        self.accessToken = validAccessToken
        self.createdAt = validCreatedAt
        print("Confirmed access token")
        //print(object ?? "")
        completion(true, nil)
    }
}













