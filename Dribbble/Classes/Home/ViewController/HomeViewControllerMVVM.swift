//
//  HomeViewControllerMVVM.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/12/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import PureLayout
import MJRefresh

class HomeViewControllerMVVM: SUIViewController {
    
    fileprivate var collectionView: UICollectionView?
    fileprivate let homeCellId = "HomeCollectionViewCell"
    fileprivate var dataManager: HomeViewDataManager?
    
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
        self.navigationItem.rightBarButtonItem?.title? = "skip"
        self.dataManager = HomeViewDataManager(contentType: contentType)
        self.dataManager?.delegate = self
    }
}

// MARK: - HomeViewDataManagerDelegate
extension HomeViewControllerMVVM: HomeViewDataManagerDelegate {
    
    func homeViewDataManager(_ manager: HomeViewDataManager, didTapUser: String) {
        let viewcontroller = PlayerProfileViewController()
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    func homeViewDidSelectCell(_ manager: HomeViewDataManager, didTapCell: String) {
        let viewcontroller = ShotDetailViewController()
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    func homeViewDataManagerReloadCollectionView() {
        collectionView?.reloadData()
    }
    
    func homeViewDataManagerHeaderEndRefreshing() {
        collectionView?.mj_header.endRefreshing()
    }
    
    func homeViewDataManagerFooterEndRefreshing() {
        collectionView?.mj_footer.endRefreshing()
    }
}

fileprivate typealias Utilities = HomeViewControllerMVVM
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
        
        collectionView.delegate = dataManager
        collectionView.dataSource = dataManager
        
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
        dataManager?.refreshAll()
    }
    
    @objc func loadMoreShots() {
        dataManager?.loadMore()
    }
}

