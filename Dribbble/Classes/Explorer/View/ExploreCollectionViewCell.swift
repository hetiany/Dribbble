//
//  EXploreCollectionViewCell.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

class ExploreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userHeadImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var displayObject: ExploreCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userHeadImageView.contentMode = .scaleAspectFit
        contentImageView.contentMode = .scaleAspectFit
        userHeadImageView.image = UIImage(named: "UserHeadPlaceHolder")
        contentImageView.image = UIImage(named: "ContentImagePlaceHolder")
    }
    
    func updateUI() {
        guard let displayObject = displayObject else {
            userHeadImageView.image = UIImage(named: "UserHeadPlaceHolder")
            contentImageView.image = UIImage(named: "ContentImagePlaceHolder")
            return
        }
        userHeadImageView.sd_setImage(with: displayObject.userHeadImageUrl)
        userNameLabel.text = displayObject.userName
        contentImageView.sd_setImage(with: displayObject.contentImageUrl)
        titleLabel.text = displayObject.title
    }

}
