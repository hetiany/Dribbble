//
//  Shot.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import ObjectMapper

class Shot: Mappable {
    var id: Int?
    var title: String?
    var description: String?
    var width: Int?
    var height: Int?
    var images: ShotImage?
    var views_count: Int?
    var likes_count: Int?
    var comments_count: Int?
    var created_at: String?
    var comments_url: String?
    var animated: Bool?
    var user: User?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id             <- map["id"]
        title          <- map["title"]
        description    <- map["description"]
        width          <- map["width"]
        height         <- map["height"]
        images         <- map["images"]
        views_count    <- map["views_count"]
        likes_count    <- map["likes_count"]
        comments_count <- map["comments_count"]
        created_at     <- map["created_at"]
        comments_url   <- map["comments_url"]
        animated       <- map["animated"]
        user           <- map["user"]
    }
}
