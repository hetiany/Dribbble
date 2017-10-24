//
//  PlayerShotSummaryViewModel.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/23/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

class PlayerShotSummaryViewModel {
    
    var playerShotHeaderURL: URL?
    var playerShotsCount: Int?
    var playerFollowerCount: Int?
    var playerFollowingCount: Int?
    var playerName: String?
    var playerLocaton: String?
    var playerDescription: String?
    
    init(model: User) {
        playerShotHeaderURL = URL(string: (model.avatar_url ?? ""))
        playerShotsCount = model.shots_count
        playerFollowerCount = model.followers_count
        playerFollowingCount = model.followings_count
        playerName = model.username
        playerLocaton = model.location
        playerDescription = model.bio
    }
}
