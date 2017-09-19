//
//  HomeCollectionViewCellVIewModel.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation


class HomeCellViewModel {
    var userHeadImageUrl: URL
    var userName: String
    var contentImageUrl: URL
    var title: String
    
//    init(model: Shot) {
//        self.userHeadImageUrl = URL(string: "https://d13yacurqjgara.cloudfront.net/users/1/avatars/normal/dc.jpg?1371679243")!
//        self.userName = "Mocked User"
//        self.contentImageUrl = URL(string: "https://d13yacurqjgara.cloudfront.net/users/1/screenshots/471756/sasquatch.png")!
//        self.title = "Moked title"
//    }
    
    init(model: Shot) {
        self.userHeadImageUrl = URL(string: (model.user?.avatar_url ?? ""))!
        self.userName = model.user?.name ?? "nil"
        self.contentImageUrl = URL(string: (model.images?.teaser ?? ""))!
        self.title = model.title ?? "nil"
    }
}



