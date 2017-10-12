//
//  HomeCollectionViewCell.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeCollectionViewCellDelegate: class {
    
    func homeCellDidTapUserHeader(_ cell: HomeCollectionViewCell)
    func homeCellDidTapUserName(_ cell: HomeCollectionViewCell)
}

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userHeadImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Using Delegate
    weak var delegate: HomeCollectionViewCellDelegate?
    
    //MARK: - Using Closure
    var tapUserHeader : ((HomeCollectionViewCell) -> ())?
    var tapUserName: ((HomeCollectionViewCell) -> ())?
    
    
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
        
        //Add Gesture to UserHeader
        let tapUserHeader = UITapGestureRecognizer(target: self, action: #selector(tapHeader))
        self.userHeadImageView.isUserInteractionEnabled = true
        self.userHeadImageView.addGestureRecognizer(tapUserHeader)
        
        //Add Gesture to UserName
        let tapUserName = UITapGestureRecognizer(target: self, action: #selector(tapName))
        self.userNameLabel.isUserInteractionEnabled = true
        self.userNameLabel.addGestureRecognizer(tapUserName)
    }
    
    @objc func tapHeader() {
        
        print("Header")
        delegate?.homeCellDidTapUserHeader(self)
        //tapUserHeader?(self)
    }
    
    @objc func tapName() {
        
        print("Name")
        delegate?.homeCellDidTapUserName(self)
        //tapUserName?(self)
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
