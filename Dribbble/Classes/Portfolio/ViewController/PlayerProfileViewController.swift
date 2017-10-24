//
//  UserProfileViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/2/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import MJRefresh

class PlayerProfileViewController: SUIViewController {
    
    fileprivate var playerCollectionView: UICollectionView?
    fileprivate let playerShotSummaryId = "PlayerShotSummaryView"
    fileprivate let playerShotViewId = "PlayerShotViewCell"
    
    var userId: Int?
    var user: User?
    var shots: [Shot] = []
    var playerSummary: PlayerShotSummaryViewModel?
    fileprivate var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareRefresher()
        // Do any additional setup after loading the view.
    }

}

extension PlayerProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playerShotViewId, for: indexPath) as! PlayerShotViewCell
        
        cell.displayURL = URL(string: shots[indexPath.row].images?.normal ?? "")
        cell.updateUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
        
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: playerShotSummaryId, for: indexPath) as! PlayerShotSummaryView
            header.displayModel = playerSummary
            header.updateUI()
            return header
        }
        return UICollectionReusableView()
    }
}


extension PlayerProfileViewController: UICollectionViewDelegate {
    
    
}


fileprivate typealias Utilities = PlayerProfileViewController
extension Utilities {
    
    func prepareCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let itemSpacing: CGFloat = 5
        let itemWidth = (ScreenWidth - layout.sectionInset.left - layout.sectionInset.right - itemSpacing * 2) / 3
        let itemHeight = ScreenHeight / 5
        
        //print("ScreenWidth is \(ScreenWidth)")
        //print("ScreenHeight is \(ScreenHeight)")
        
        //print("itemWidth is \(itemWidth)")
        //print("itemHeight is \(itemHeight)")
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        //layout.headerReferenceSize = UICollectionViewFlowLayoutAutomaticSize
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: 250)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        playerCollectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let playerShotSummaryNib = UINib(nibName: playerShotSummaryId, bundle: Bundle(for: type(of: self)))
        collectionView.register(playerShotSummaryNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: playerShotSummaryId)
        
        let playerShotViewNib = UINib(nibName: playerShotViewId, bundle: Bundle(for: type(of: self)))
        collectionView.register(playerShotViewNib, forCellWithReuseIdentifier: playerShotViewId)
        
        collectionView.backgroundColor = .groupTableViewBackground
        self.view.addSubview(collectionView)
    }
    
    func prepareRefresher() {
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshNew))
        header?.beginRefreshing()
        playerCollectionView?.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
        //footer?.setTitle("No more shots", for: .noMoreData)
        playerCollectionView?.mj_footer = footer
        //footer?.beginRefreshing()
    }
    
    @objc func refreshNew() {
        
        page = 1
        guard let userId = userId else {
            return
        }
        
        DataTools.fetchUser(page: page, userId: userId, success: { (results) in
            if let results = results {
                self.user = results
                self.playerSummary =  PlayerShotSummaryViewModel(model: results)
                
                DataTools.fetchUserShots(page: self.page, url: self.user?.shots_url ?? "", success: { (results) in
                    self.shots.removeAll()
                    if let results = results {
                        self.shots.append(contentsOf: results)
                        self.playerCollectionView?.reloadData()
                    }
                    self.playerCollectionView?.mj_header.endRefreshing()
                    self.playerCollectionView?.mj_footer.endRefreshing()
                    print("referesh")
                    
                }, failure: { (error) in
                    print(error?.localizedDescription ?? "Unknown Error")
                    self.playerCollectionView?.mj_header.endRefreshing()
                    self.playerCollectionView?.mj_footer.endRefreshing()
                })
                
                self.playerCollectionView?.reloadData()
            }
            self.playerCollectionView?.mj_header.endRefreshing()
            self.playerCollectionView?.mj_footer.endRefreshing()
            print("referesh")
            
        }, failure: { (error) in
            print(error?.localizedDescription ?? "Unknown Error")
            self.playerCollectionView?.mj_header.endRefreshing()
            self.playerCollectionView?.mj_footer.endRefreshing()
        })
    }

    
    @objc func loadMore() {
        
        self.page += 1
        guard let userId = userId else {
            return
        }
        DataTools.fetchUser(page: page, userId: userId, success: { (results) in
            if let results = results {
                self.playerSummary =  PlayerShotSummaryViewModel(model: results)
                
                DataTools.fetchUserShots(page: self.page, url: self.user?.shots_url ?? "", success: { (results) in
                    if let results = results {
                        //print(results)
                        self.shots.append(contentsOf: results)
                        //print(self.shots)
                        self.playerCollectionView?.reloadData()
                    }
                    self.playerCollectionView?.mj_header.endRefreshing()
                    self.playerCollectionView?.mj_footer.endRefreshing()
                    print("referesh")
                    
                }, failure: { (error) in
                    print(error?.localizedDescription ?? "Unknown Error")
                    self.playerCollectionView?.mj_header.endRefreshing()
                    self.playerCollectionView?.mj_footer.endRefreshing()
                })
                
                self.playerCollectionView?.mj_footer.endRefreshing()
                self.playerCollectionView?.reloadData()
            }
            else {
                self.playerCollectionView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }, failure: { (error) in
            //self.page -= 1
            print(error?.localizedDescription ?? "Unknown Error")
            //playerCollectionView?.mj_header.endRefreshing()
            self.playerCollectionView?.mj_footer.endRefreshing()
        })
        //playerCollectionView?.mj_footer.endRefreshingWithNoMoreData()
    }
}
