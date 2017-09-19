//
//  ShotPicture.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import ObjectMapper

class ShotImage: Mappable {
    var hidpi: String = ""
    var normal: String = ""
    var teaser: String = ""
    
    required init?(map: Map) {
        if map.JSON["teaser"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        hidpi  <- map["hidpi"]
        normal <- map["normal"]
        teaser <- map["teaser"]
    }
}
