//
//  ShotDetailTitleView.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/11/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

class ShotDetailTitleView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var shotTitle: UILabel!
    @IBOutlet weak var authorAndTime: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    var displayShotModel: ShotDetailImageViewModel?
 
    func updateUI() {
        
        headImage.sd_setImage(with: displayShotModel?.userHeadImageUrl)
        shotTitle.text = displayShotModel?.title
        authorAndTime.text = (displayShotModel?.userName ?? "") + " on " + (displayShotModel?.creatTime?.description ?? "")
        likeCount.text = String(displayShotModel?.likeCount ?? 0)
        commentCount.text = String(displayShotModel?.commentCount ?? 0)
    }
}
