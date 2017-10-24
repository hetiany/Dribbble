//
//  ShotDetailCommentViewModel.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/15/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

class ShotDetailCommentViewModel {
    
    var commentImageURL: URL?
    var commentPoster: String?
    var commentBody: String?
    var commentCreatedTime: String?
    
    init(model: Comment) {
        commentImageURL = URL(string: (model.user?.avatar_url ?? ""))
        commentPoster = model.user?.name ?? ""
        commentBody = model.body
        commentCreatedTime = model.created_at
    }
}
