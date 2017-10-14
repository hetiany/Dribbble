//
//  ExploreCollectionViewCellVIewModel.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation


class ExploreCellViewModel {

    var contentImageUrl: URL
    
//    init(model: Shot) {
//        self.userHeadImageUrl = URL(string: "https://d13yacurqjgara.cloudfront.net/users/1/avatars/normal/dc.jpg?1371679243")!
//        self.userName = "Mocked User"
//        self.contentImageUrl = URL(string: "https://d13yacurqjgara.cloudfront.net/users/1/screenshots/471756/sasquatch.png")!
//        self.title = "Moked title"
//    }
    
    init(model: Shot) {
        
        self.contentImageUrl = URL(string: (model.images?.teaser ?? ""))!
    }
}



