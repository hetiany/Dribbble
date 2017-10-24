//
//  ShotDetailImageViewModel.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/15/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation


class ShotDetailImageViewModel {
    
    var contentImageUrl: URL?
    var userHeadImageUrl: URL?
    var title: String?
    var userName: String?
    var creatTime: String?
    var likeCount: Int?
    var commentCount: Int?
    var description: String?

    init(model: Shot) {
        self.userHeadImageUrl = URL(string: (model.user?.avatar_url ?? ""))
        self.contentImageUrl = URL(string: (model.images?.teaser ?? ""))
        self.title = model.title
        self.userName = model.user?.name
        self.creatTime = model.created_at
        self.likeCount = model.likes_count
        self.commentCount = model.comments_count
        self.description = model.description        
    }
}
