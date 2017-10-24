//
//  PlayerShotViewCell.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class PlayerShotViewCell: UICollectionViewCell {

    @IBOutlet weak var playerShotView: UIImageView!
    var displayURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI() {
        
        playerShotView.sd_setImage(with: displayURL)
    }
}
