//
//  HomeCollectionViewCell.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userHeadImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var displayObject: HomeCellViewModel? {
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
        
        //Add Gesture to ContentImage
        let tapContentImage = UITapGestureRecognizer(target:self,action:#selector(tapContent))
        //tapContentImage.numberOfTapsRequired = 1
        //tapContentImage.numberOfTouchesRequired = 1
        self.contentImageView.isUserInteractionEnabled = true
        self.contentImageView.addGestureRecognizer(tapContentImage)
        
        //Add Gesture to UserHeader
        let tapUserHeader = UITapGestureRecognizer(target: self, action: #selector(tapHeader))
        self.userHeadImageView.isUserInteractionEnabled = true
        self.userHeadImageView.addGestureRecognizer(tapUserHeader)
    }
    
    @objc func tapContent() {
        print("Image")
    }
    
    @objc func tapHeader() {
        print("Header")
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
