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

    @IBOutlet weak var contentImageView: UIImageView!
    
    var displayObject: ExploreCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.image = UIImage(named: "ContentImagePlaceHolder")
    }
    
    func updateUI() {
        guard let displayObject = displayObject else {
    
            contentImageView.image = UIImage(named: "ContentImagePlaceHolder")
            return
        }
        contentImageView.sd_setImage(with: displayObject.contentImageUrl)
    }

}
