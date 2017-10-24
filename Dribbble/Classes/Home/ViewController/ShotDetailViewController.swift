//
//  ShotDetailViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/2/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import PureLayout
import MJRefresh

class ShotDetailViewController: SUIViewController {

    fileprivate var shotTableView: UITableView?
    fileprivate let shotDetailImageId = "ShotDetailImageViewCell"
    //fileprivate let shotDetailTitleId = "ShotDetailTitleViewCell"
    fileprivate let shotDetailTitleId = "ShotDetailTitleView"
    fileprivate let shotDetailDescribeId = "ShotDetailDescribeViewCell"
    fileprivate let shotDetailCommentId = "ShotDetailCommentViewCell"
    
    var shotDetailImageDescript: ShotDetailImageViewModel?
    var shot: Shot?
    var page: Int = 1
    var comments: [Comment] = []

    init(model: Shot) {
        
        super.init(nibName: nil, bundle: nil)
        shot = model
        shotDetailImageDescript = ShotDetailImageViewModel(model: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareRefresher()
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
            return comments.count + 1
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
            
            shotImageCell.displayURL = shotDetailImageDescript?.contentImageUrl
            shotImageCell.updateUI()
            return shotImageCell
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let shotDescribeCell = tableView.dequeueReusableCell(withIdentifier: shotDetailDescribeId, for: indexPath) as! ShotDetailDescribeViewCell
                
                if let shotDescribe = shotDetailImageDescript?.description {
                    shotDescribeCell.shotDescribe.text = shotDescribe
                } else {
                    shotDescribeCell.shotDescribe.text = "No Description"
                }
                return shotDescribeCell
            }
            else {
                let shotCommentCell = tableView.dequeueReusableCell(withIdentifier: shotDetailCommentId, for: indexPath) as!ShotDetailCommentViewCell
                
                shotCommentCell.displayObject = ShotDetailCommentViewModel(model: comments[indexPath.row - 1])
                shotCommentCell.updateUI()
                return shotCommentCell
            }
        }
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: shotDetailTitleId) as! ShotDetailTitleView
            header.displayShotModel = shotDetailImageDescript
        // Using Cell as Header
//            let header = shotTableView?.dequeueReusableCell(withIdentifier: shotDetailTitleId) as? ShotDetailTitleViewCell
            header.contentView.backgroundColor = .white
            header.updateUI()
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
            if #available(iOS 11.0, *) {
                //return UITableViewAutomaticDimension
            }
            return 106
        }
        return 0
    }
}

fileprivate typealias Utilities = ShotDetailViewController
fileprivate extension Utilities {
    
    func prepareTableView() {
        
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
//        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
//        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        //tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            //tableView.contentInsetAdjustmentBehavior = .automatic
        } else {
            
        }
        
        // MARK: - register xibs
        let shotDetailImageNib = UINib(nibName: shotDetailImageId, bundle: Bundle(for: type(of: self)))
        tableView.register(shotDetailImageNib, forCellReuseIdentifier: shotDetailImageId)
        
        
        let shotDetailTitleNib = UINib(nibName: shotDetailTitleId, bundle: Bundle(for: type(of: self)))
        tableView.register(shotDetailTitleNib, forHeaderFooterViewReuseIdentifier: shotDetailTitleId)
        //tableView.register(shotDetailTitleNib, forCellReuseIdentifier: shotDetailTitleId)
        
        
        let shotDetailDescribeNib = UINib(nibName: shotDetailDescribeId, bundle: nil)
        tableView.register(shotDetailDescribeNib, forCellReuseIdentifier: shotDetailDescribeId)
        
        let shotDetailCommentNib = UINib(nibName: shotDetailCommentId, bundle: nil)
        tableView.register(shotDetailCommentNib, forCellReuseIdentifier: shotDetailCommentId)
        
        
        self.view.addSubview(tableView)
        shotTableView = tableView
        //tableView.autoPinEdgesToSuperviewEdges()
    }
    
    func prepareRefresher() {
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshNewComments))
        header?.beginRefreshing()
        shotTableView?.mj_header = header

        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMoreComments))
        //footer?.setTitle("No more shots", for: .noMoreData)
        shotTableView?.mj_footer = footer
        //footer?.beginRefreshing()
    }
    
    
    @objc func refreshNewComments() {
        
        page = 1
        guard let shotId = shot?.id else {
            return
        }
        DataTools.fetchComment(page: page, id: shotId, success: { (results) in
            if let results = results {
                self.comments = results
                self.shotTableView?.reloadData()
            }
            self.shotTableView?.mj_header.endRefreshing()
            self.shotTableView?.mj_footer.endRefreshing()
            print("referesh")

        }, failure: { (error) in
            print(error?.localizedDescription ?? "Unknown Error")
            self.shotTableView?.mj_header.endRefreshing()
            self.shotTableView?.mj_footer.endRefreshing()
        })
    }
    
    @objc func loadMoreComments() {
        
        self.page += 1
        guard let shotId = shot?.id else {
            return
        }
        DataTools.fetchComment(page: page, id: shotId, success: { (results) in
            if let results = results {
                self.comments.append(contentsOf: results)
                self.shotTableView?.mj_footer.endRefreshing()
                self.shotTableView?.reloadData()
                //self.page += 1
            }
            else {
                self.shotTableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }, failure: { (error) in
            //self.page -= 1
            print(error?.localizedDescription ?? "Unknown Error")
            //self.shotTableView?.mj_header.endRefreshing()
            self.shotTableView?.mj_footer.endRefreshing()
        })
        //shotTableView?.mj_footer.endRefreshingWithNoMoreData()
    }
}


