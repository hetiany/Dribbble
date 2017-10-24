//
//  PlayerShotSummaryView.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/10/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

class PlayerShotSummaryView: UICollectionReusableView {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerShotCount: UILabel!
    @IBOutlet weak var playerFollowerCount: UILabel!
    @IBOutlet weak var playerFollowingCount: UILabel!
    @IBAction func playerFollowingButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerLocation: UILabel!
    @IBOutlet weak var playerDescription: UILabel!
    
    var displayModel: PlayerShotSummaryViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    func updateUI() {
        playerImage.sd_setImage(with: displayModel?.playerShotHeaderURL)
        playerShotCount.text = String(displayModel?.playerShotsCount ?? 0)
        playerFollowerCount.text = String(displayModel?.playerFollowerCount ?? 0)
        playerFollowingCount.text = String(displayModel?.playerFollowingCount ?? 0)
        playerName.text = displayModel?.playerName
        playerLocation.text = displayModel?.playerLocaton
        playerDescription.text = displayModel?.playerDescription
    }
}
