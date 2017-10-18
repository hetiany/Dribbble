//
//  Comment.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/15/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    
    var body: String?
    var created_at: String?
    var user: User?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        body        <- map["body"]
        created_at  <- map["created_at"]
        user        <- map["user"]
    }
}
