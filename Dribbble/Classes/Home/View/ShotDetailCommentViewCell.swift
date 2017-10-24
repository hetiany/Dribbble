//
//  ShotDetailCommentViewCell.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/3/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

class ShotDetailCommentViewCell: UITableViewCell {

    
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentPoster: UILabel!
    @IBOutlet weak var commentBody: UILabel!
    @IBOutlet weak var commentCreatedTime: UILabel!
    
    var displayObject: ShotDetailCommentViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI() {
        commentImage.sd_setImage(with: displayObject?.commentImageURL)
        commentPoster.text = displayObject?.commentPoster
        commentBody.text = displayObject?.commentBody
        commentCreatedTime.text = displayObject?.commentCreatedTime
    }
}
