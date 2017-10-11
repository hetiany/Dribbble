//
//  HomeViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import PureLayout
import MJRefresh


class HomeViewController: SUIViewController {
    
    fileprivate weak var collectionView: UICollectionView?
    fileprivate let homeCellId = "HomeCollectionViewCell"
    
    var shots: [HomeCellViewModel] = []
        
    var contentType: ContentType = .recent
    
    var page: Int = 1

    override func viewDidLoad() {
        
        super.viewDidLoad()
        prepareCollectionView()
        prepareRefresher()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(contentType: ContentType) {
        
        self.init(nibName: nil, bundle: nil)
        self.title = contentType.title
        self.contentType = contentType
        self.navigationItem.rightBarButtonItem?.title? = "skip"
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        let viewcontroller = ShotDetailViewController()
//        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomeCollectionViewCell
        cell.displayObject = shots[indexPath.row]
        return cell
    }
}


fileprivate typealias Utilities = HomeViewController
fileprivate extension Utilities {
    
    func prepareCollectionView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 5
        let itemWidth = (ScreenWidth - itemSpacing * 3) / 2
        let itemHeight = ScreenHeight / 3
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        let homeNib = UINib(nibName: homeCellId, bundle: Bundle(for: type(of: self)))
        collectionView.register(homeNib, forCellWithReuseIdentifier: homeCellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        self.collectionView = collectionView
        self.view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    func prepareRefresher() {
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshNewShots))
        header?.beginRefreshing()
        collectionView?.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMoreShots))
        footer?.setTitle("No more shots", for: .noMoreData)
        collectionView?.mj_footer = footer
    }
    
    
    @objc func refreshNewShots() {
        
        page = 1
        DataTools.fetchShots(contentTpye: contentType, page: page, success: { (results) in
            if let results = results {
                //print(results[0].user?.avatar_url ?? "nil")
                self.shots.removeAll()
                for i in 0..<results.count {
                    self.shots.append(HomeCellViewModel.init(model: results[i]))
                }
                //print(self.shots[0].userHeadImageUrl)
                self.collectionView?.reloadData()
            }
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()

        }, failure: { (error) in
            print(error?.localizedDescription ?? "Unknown Error")
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
        })
    }
    
    @objc func loadMoreShots() {
        
        page += 1
        DataTools.fetchShots(contentTpye: contentType, page: page, success: { (results) in
            if let results = results {
                //print(results[0].user?.avatar_url ?? "nil")
                for i in 0..<results.count {
                    self.shots.append(HomeCellViewModel.init(model: results[i]))
                }
                //print(self.shots[0].userHeadImageUrl)
                self.collectionView?.reloadData()
            }
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
            
        }, failure: { (error) in
            self.page -= 1
            print(error?.localizedDescription ?? "Unknown Error")
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
        })
        
        //collectionView?.mj_footer.endRefreshingWithNoMoreData()
    }
}











