//
//  HomeCollectionViewCellVIewModel.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation


class HomeCellViewModel {
    var userId: Int?
    var userHeadImageUrl: URL?
    var userName: String?
    var contentImageUrl: URL?
    var title: String?
    var creatTime: String?
    var likeCount: Int?
    var commentCount: Int?
    var description: String?

    
//    init(model: Shot) {
//        self.userHeadImageUrl = URL(string: "https://d13yacurqjgara.cloudfront.net/users/1/avatars/normal/dc.jpg?1371679243")!
//        self.userName = "Mocked User"
//        self.contentImageUrl = URL(string: "https://d13yacurqjgara.cloudfront.net/users/1/screenshots/471756/sasquatch.png")!
//        self.title = "Moked title"
//    }
    
    init(model: Shot) {
        self.userId = model.user?.id
        self.userHeadImageUrl = URL(string: (model.user?.avatar_url ?? ""))
        self.userName = model.user?.name
        self.contentImageUrl = URL(string: (model.images?.normal ?? ""))
        self.title = model.title
        self.creatTime = model.created_at
        self.likeCount = model.likes_count
        self.commentCount = model.likes_count
        self.description = model.description
    }
}



