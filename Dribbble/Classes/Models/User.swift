//
//  User.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int?
    var name: String?
    var username: String?
    var bio: String?
    var location: String?
    var followers_count: Int?
    var followings_count: Int?
    var likes_count: Int?
    var shots_count: Int?
    var shots_url: String?
    var likes_url: String?
    var avatar_url: String?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        id               <- map["id"]
        name             <- map["name"]
        username         <- map["username"]
        bio              <- map["bio"]
        location         <- map["location"]
        followers_count  <- map["follower_count"]
        followings_count <- map["followings_count"]
        likes_count      <- map["likes_count"]
        shots_count      <- map["shots_count"]
        shots_url        <- map["shots_url"]
        likes_url        <- map["likes_url"]
        avatar_url       <- map["avatar_url"]
    }

}
