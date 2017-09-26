//
//  Constants.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

let accessParameter = "access_token="
let pageParameter = "page="

let base = "https://api.dribbble.com/v1/"
let authUrl = "https://dribbble.com/oauth/authorize"
let tokenUrl = "https://dribbble.com/oauth/token"

//Shots End Point
let shotsRecentEndPoint = "https://api.dribbble.com/v1/shots?sort=recent&"
let shotsPopularEndPoint = "https://api.dribbble.com/v1/shots?"
let shotsFollowingEndPoint = "https://api.dribbble.com/v1/user/following/shots?"
let shotsDebutsEndPoint = "https://api.dribbble.com/v1/shots?list=debuts&"
let shotsTeamsEndPoint = "https://api.dribbble.com/v1/shots?list=teams&"
let shotsPlayoffsEndPoint = "https://api.dribbble.com/v1/shots?list=playoffs&"


//User End Point
let userEndPoint = "https://api.dribbble.com/v1/user"
let usersEndPoint = "https://api.dribbble.com/v1/users"
let followShotEndPoint = "https://api.dribbble.com/v1/user/following/shots"





//    func getToken() -> String?{
//        return userDefault.object(forKey: Keys.kUserDefaultAccessToken) as? String
//    }
//
//    func setToken(_ newValue: String) {
//        userDefault.set(newValue, forKey: Keys.kUserDefaultAccessToken)
//    }





enum ContentType: String {
    case recent
    case popular
    case following
    case debuts
    case teams
    case playoffs
    
    var title: String {
        return self.rawValue
    }
}


