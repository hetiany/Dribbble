//
//  ShotDetailViewControllerMVVM.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/13/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class ShotDetailViewControllerMVVM: SUIViewController {
    
    fileprivate var dataManager: ShotDetailViewDataManager?
    fileprivate var shotTableView: UITableView?
    
    fileprivate let shotDetailImageId = "ShotDetailImageViewCell"
    //fileprivate let shotDetailTitleId = "ShotDetailTitleViewCell"
    fileprivate let shotDetailTitleId = "ShotDetailTitleView"
    fileprivate let shotDetailDescribeId = "ShotDetailDescribeViewCell"
    fileprivate let shotDetailCommentId = "ShotDetailCommentViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        prepareTableView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        //self.title = contentType.title
        //self.dataManager = ShotDetailViewDataManager(contentType: contentType)
        self.dataManager = ShotDetailViewDataManager()
        self.dataManager?.delegate = self
    }
}

extension ShotDetailViewControllerMVVM: ShotDetailViewDelegate {
    
    func shotDetailViewDidSelectCell(_ manager: ShotDetailViewDataManager, didTapCell: String) {
        
    }
}

fileprivate typealias Utilities = ShotDetailViewControllerMVVM
fileprivate extension Utilities {
    
    func prepareTableView() {
        
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 2
        //tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        tableView.delegate = dataManager
        tableView.dataSource = dataManager
        
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
}
