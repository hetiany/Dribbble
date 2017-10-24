//
//  ShotDetailImageViewCell.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/3/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import SDWebImage

class ShotDetailImageViewCell: UITableViewCell {
    
    @IBOutlet weak var shotDetailImage: UIImageView!
    //@IBOutlet weak var shotHeight: NSLayoutConstraint?
    var shotHeight: NSLayoutConstraint!
    var displayURL: URL?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        shotDetailImage.contentMode = .scaleAspectFit
        shotDetailImage.translatesAutoresizingMaskIntoConstraints = false
        
        shotHeight = NSLayoutConstraint(item: shotDetailImage, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0.0, constant: 0)
        shotDetailImage.addConstraint(shotHeight)
    }
    
    func updateUI() {
        
        let ratio = (CGFloat)(3.0 / 4.0)
        //print("ratio\(ratio)")
        let cellWidth = UIScreen.main.bounds.width
        let shotHeightValue = ratio * cellWidth
       // print("old shotHeight \(shotHeight.constant)")
        shotHeight.constant = shotHeightValue
        //print("new shotHeight \(shotHeight.constant)")
        //self.layoutIfNeeded()
        
        guard let displayURL = displayURL else {
            //shotDetailImage.image = UIImage(named: "ContentImagePlaceHolder")
            return
        }
        shotDetailImage.sd_setImage(with: displayURL)

    }
}
