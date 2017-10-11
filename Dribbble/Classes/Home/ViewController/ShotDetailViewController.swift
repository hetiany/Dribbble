//
//  ShotDetailViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/2/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class ShotDetailViewController: UIViewController {

    fileprivate var shotTableView: UITableView?
    fileprivate let shotDetailImageId = "ShotDetailImageViewCell"
    fileprivate let shotDetailTitleId = "ShotDetailTitleViewCell"
    fileprivate let shotDetailDescribeId = "ShotDetailDescribeViewCell"
    fileprivate let shotDetailCommentId = "ShotDetailCommentViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        // Do any additional setup after loading the view.
    }

}

extension ShotDetailViewController: UITableViewDataSource {
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: shotDetailImageId, for: indexPath) as! ShotDetailImageViewCell
            cell.updateUI()
            return cell
        }
        else if indexPath.section == 1{
            if indexPath.row == 0 {
                let cell = shotTableView?.dequeueReusableCell(withIdentifier: shotDetailDescribeId, for: indexPath)
                guard let shotDescribeCell = cell as? ShotDetailDescribeViewCell else {
                    fatalError("Invalid reuse id")
                    return UITableViewCell()
                }
                return shotDescribeCell
            }
            else {
                let cell = shotTableView?.dequeueReusableCell(withIdentifier: shotDetailCommentId, for: indexPath)
                guard let shotCommentCell = cell as? ShotDetailCommentViewCell else {
                    fatalError("Invalid reuse id")
                    return UITableViewCell()
                }
                return shotCommentCell
                
            }

        }
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 1 {
            //let cell = shotTableView?.dequeueReusableHeaderFooterView(withIdentifier: shotDetailTitleId)
            //let header = cell as? ShotDetailTitleView
            //let header = ShotDetailTitleView(reuseIdentifier: shotDetailTitleId)
            //header.backgroundView?.backgroundColor = bgColor

            let header = shotTableView?.dequeueReusableCell(withIdentifier: shotDetailTitleId) as? ShotDetailTitleViewCell
            header?.backgroundColor = .white
            return header
        }
       return UIView()
    }
}


extension ShotDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        if section == 1 {
//            if #available(iOS 11.0, *) {
//                return UITableViewAutomaticDimension
//            }
            return 120
        }
        return 0
    }
}

fileprivate typealias Utilities = ShotDetailViewController
fileprivate extension Utilities {
    
    func prepareTableView() {
        
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 2
        //tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            //tableView.contentInsetAdjustmentBehavior = .automatic
        } else {
            
        }
        
        
        // MARK: register xibs
        let shotDetailImageNib = UINib(nibName: shotDetailImageId, bundle: Bundle(for: type(of: self)))
        tableView.register(shotDetailImageNib, forCellReuseIdentifier: shotDetailImageId)
        
        
        let shotDetailTitleNib = UINib(nibName: shotDetailTitleId, bundle: Bundle(for: type(of: self)))
        //tableView.register(shotDetailTitleNib, forHeaderFooterViewReuseIdentifier: shotDetailTitleId)
        tableView.register(shotDetailTitleNib, forCellReuseIdentifier: shotDetailTitleId)
        
        
        let shotDetailDescribeNib = UINib(nibName: shotDetailDescribeId, bundle: nil)
        tableView.register(shotDetailDescribeNib, forCellReuseIdentifier: shotDetailDescribeId)
        
        let shotDetailCommentNib = UINib(nibName: shotDetailCommentId, bundle: nil)
        tableView.register(shotDetailCommentNib, forCellReuseIdentifier: shotDetailCommentId)
        
        
        self.view.addSubview(tableView)
        shotTableView = tableView
        //tableView.autoPinEdgesToSuperviewEdges()
    }
}


