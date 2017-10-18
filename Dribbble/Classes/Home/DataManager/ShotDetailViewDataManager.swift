//
//  ShotDetailViewDataManager.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/13/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

protocol ShotDetailViewDelegate: class {
    
    func shotDetailViewDidSelectCell(_ manager: ShotDetailViewDataManager, didTapCell: String)
}

class ShotDetailViewDataManager: NSObject {
    
    weak var delegate: ShotDetailViewDelegate?
    //var contentType: ContentType?
    
    fileprivate let shotDetailImageId = "ShotDetailImageViewCell"
    //fileprivate let shotDetailTitleId = "ShotDetailTitleViewCell"
    fileprivate let shotDetailTitleId = "ShotDetailTitleView"
    fileprivate let shotDetailDescribeId = "ShotDetailDescribeViewCell"
    fileprivate let shotDetailCommentId = "ShotDetailCommentViewCell"
    
    override init() {
        super.init()
    }
    
   // convenience init() {
     //   self.init()
        //self.contentType = contentType
    //}
    
}

extension ShotDetailViewDataManager:  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 22
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //            let cell = shotTableView?.dequeueReusableCell(withIdentifier: shotDetailImageId, for: indexPath)
            //
            //            guard let shotImageCell = cell as? ShotDetailImageViewCell else {
            //                fatalError("Invalid reuse id")
            //                return UITableViewCell()
            //            }
            //            shotImageCell.updateUI()
            //            return shotImageCell
            
            let shotImageCell = tableView.dequeueReusableCell(withIdentifier: shotDetailImageId, for: indexPath) as! ShotDetailImageViewCell
            shotImageCell.updateUI()
            return shotImageCell
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let shotDescribeCell = tableView.dequeueReusableCell(withIdentifier: shotDetailDescribeId, for: indexPath) as! ShotDetailDescribeViewCell
                return shotDescribeCell
            }
            else {
                let shotCommentCell = tableView.dequeueReusableCell(withIdentifier: shotDetailCommentId, for: indexPath) as!ShotDetailCommentViewCell
                return shotCommentCell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: shotDetailTitleId) as! ShotDetailTitleView
            
            // Using Cell as Header
            //            let header = shotTableView?.dequeueReusableCell(withIdentifier: shotDetailTitleId) as? ShotDetailTitleViewCell
            
            header.contentView.backgroundColor = .white
            return header
        }
        return UIView()
    }
}

extension ShotDetailViewDataManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.shotDetailViewDidSelectCell(self, didTapCell: "")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            if #available(iOS 11.0, *) {
                //return UITableViewAutomaticDimension
            }
            return 120
        }
        return 0
    }
}


