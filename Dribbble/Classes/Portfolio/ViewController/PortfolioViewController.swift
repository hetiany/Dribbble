//
//  PortfolioViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import WebKit
import PureLayout
import MJRefresh

class PortfolioViewController: SUIViewController {

    let accountManager = AccountManager.shared
    
    var tableView: UITableView?
    var headImage: UIImageView?
    var name: UILabel?
    var registerTime: UILabel?
    var page: Int = 1
    
    let PortfolioDetail = ["Likes",
                      "Following",
                      "Followers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareTableView()
        prepareRefresher()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension PortfolioViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PortfolioDetail.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioDetailViewCell", for: indexPath)
        guard let detailCell = cell as? PortfolioDetailViewCell else {
            fatalError("Invalid reuse id")
            return UITableViewCell()
        }
        detailCell.accessoryType = .disclosureIndicator
        detailCell.detailName.text = PortfolioDetail[indexPath.row]
        return detailCell
    }

}

extension PortfolioViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

fileprivate typealias Utilities = PortfolioViewController
fileprivate extension Utilities {
    
    func prepareUI() {
        self.view.backgroundColor = .gray
        
        // layout headImage
        let headImage = UIImageView()
        headImage.image = UIImage(named: "ContentImagePlaceHolder")
        headImage.backgroundColor = .yellow
        headImage.contentMode = .scaleAspectFit
        //headImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headImage)
        self.headImage = headImage
        headImage.autoSetDimensions(to: CGSize(width: 100, height: 100))
        //headImage.layer.cornerRadius = 30
        //headImage.layer.masksToBounds = true
        headImage.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        headImage.autoAlignAxis(toSuperviewAxis: .vertical)
    
        
        // layout name
        let name = UILabel()
        name.text = "Hetian Yang"
        self.view.addSubview(name)
        self.name = name
        name.autoAlignAxis(toSuperviewAxis: .vertical)
        name.autoPinEdge(.top, to: .bottom, of: headImage, withOffset: 16)
        
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.didTapLogout))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapLogout() {
        
        accountManager.resetAccessToken(to: nil)
        let dataTypes = [WKWebsiteDataTypeCookies,
                         WKWebsiteDataTypeLocalStorage,
                         WKWebsiteDataTypeMemoryCache,
                         WKWebsiteDataTypeDiskCache,
                         WKWebsiteDataTypeSessionStorage,
                         WKWebsiteDataTypeWebSQLDatabases,
                         WKWebsiteDataTypeIndexedDBDatabases,
                         WKWebsiteDataTypeOfflineWebApplicationCache]
        let dataTypeSet = Set(dataTypes)
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypeSet, modifiedSince: Date.distantPast, completionHandler: {
            DispatchQueue.main.async {
                print("clear ok")
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                //self.present(nav, animated: true, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        })
    }
    
    func prepareTableView() {
        
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        //tableView.backgroundColor = .gray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        self.view.addSubview(tableView)
        self.tableView = tableView
        tableView.register(UINib(nibName: "PortfolioDetailViewCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "PortfolioDetailViewCell")
        
        
        //tableView.register(PortfolioDetailViewCell.self)
        
        //tableView.autoAlignAxis(toSuperviewAxis: .vertical)
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: .top)
        tableView.autoPinEdge(.top, to: .bottom, of: name!, withOffset: 16)
    }
    
    func prepareRefresher() {
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshNew))
        header?.beginRefreshing()
        tableView?.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
        //footer?.setTitle("No more shots", for: .noMoreData)
        tableView?.mj_footer = footer
        //footer?.beginRefreshing()
    }
    
    
    @objc func refreshNew() {
        
        page = 1
//        guard let userId = userId else {
//            return
//        }
        DataTools.fetchAuthUser(page: page, success: { (results) in
            if let results = results {
                //self.comments = results
                //print(results.username)
                self.tableView?.reloadData()
            }
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.mj_footer.endRefreshing()
            print("referesh")
            
        }, failure: { (error) in
            print(error?.localizedDescription ?? "Unknown Error")
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.mj_footer.endRefreshing()
        })
    }
    
    @objc func loadMore() {
        
        self.page += 1
//        guard let userId = userId else {
//            return
//        }
        DataTools.fetchAuthUser(page: page, success: { (results) in
            if let results = results {
                //self.comments.append(contentsOf: results)
                
                self.tableView?.mj_footer.endRefreshing()
                self.tableView?.reloadData()
            }
            else {
                self.tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }, failure: { (error) in
            //self.page -= 1
            print(error?.localizedDescription ?? "Unknown Error")
            //playerCollectionView?.mj_header.endRefreshing()
            self.tableView?.mj_footer.endRefreshing()
        })
        //tableView?.mj_footer.endRefreshingWithNoMoreData()
    }
}
