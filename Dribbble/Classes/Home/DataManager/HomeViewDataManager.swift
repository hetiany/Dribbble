//
//  HomeViewDataManager.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/12/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewDataManagerDelegate: class {
    
    func homeViewDataManager(_ manager: HomeViewDataManager, didTapUser: String)
    func homeViewDidSelectCell(_ manager: HomeViewDataManager, didTapCell: String)
    func homeViewDataManagerReloadCollectionView()
    func homeViewDataManagerHeaderEndRefreshing()
    func homeViewDataManagerFooterEndRefreshing()
}

class HomeViewDataManager: NSObject {
    
    weak var delegate: HomeViewDataManagerDelegate?
    //weak var controller: HomeViewController?
    
    var homeCellId = "HomeCollectionViewCell"
    var displayShots: [HomeCellViewModel] = []
    var shots: [Shot] = []
    var contentType: ContentType = .recent
    
    fileprivate var page: Int = 1
    
    override init() {
        super.init()
    }
    
    convenience init(contentType: ContentType) {
        self.init()
        self.contentType = contentType
    }
}

//MARK: - HomeCollectionViewCellDelegate
extension HomeViewDataManager: HomeCollectionViewCellDelegate {
    
    func homeCellDidTapUserName(_ cell: HomeCollectionViewCell) {
        
        delegate?.homeViewDataManager(self, didTapUser: "")
    }
    
    func homeCellDidTapUserHeader(_ cell: HomeCollectionViewCell) {
        
        delegate?.homeViewDataManager(self, didTapUser: "")
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewDataManager: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        delegate?.homeViewDidSelectCell(self, didTapCell: "")
    }
}


extension HomeViewDataManager: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayShots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomeCollectionViewCell
        cell.delegate = self
        cell.displayObject = displayShots[indexPath.row]
        return cell
    }
}

// MARK: - event handler
extension HomeViewDataManager {
    
    func refreshAll() {
        
        page = 1
        DataTools.fetchShots(contentTpye: contentType, page: page, success: { [weak self] (results) in
            
            if let results = results {
                self?.shots.removeAll()
                self?.displayShots.removeAll()
                self?.shots = results
                for i in 0..<results.count {
                    self?.displayShots.append(HomeCellViewModel.init(model: results[i]))
                }
                self?.delegate?.homeViewDataManagerReloadCollectionView()
            }
            self?.delegate?.homeViewDataManagerHeaderEndRefreshing()
            self?.delegate?.homeViewDataManagerHeaderEndRefreshing()
        }, failure: { [weak self] (error) in
            print(error?.localizedDescription ?? "Unknown Error")
            self?.delegate?.homeViewDataManagerHeaderEndRefreshing()
            self?.delegate?.homeViewDataManagerHeaderEndRefreshing()

        })
    }
    
    func loadMore() {
        
        page += 1
        DataTools.fetchShots(contentTpye: contentType, page: page, success: { [weak self](results) in
            if let results = results {
                for i in 0..<results.count {
                    self?.shots.append(results[i])
                    self?.displayShots.append(HomeCellViewModel.init(model: results[i]))
                }
                self?.delegate?.homeViewDataManagerReloadCollectionView()
            }
            self?.delegate?.homeViewDataManagerHeaderEndRefreshing()
            self?.delegate?.homeViewDataManagerFooterEndRefreshing()
            
        }, failure: { [weak self] (error) in
            self?.page -= 1
            print(error?.localizedDescription ?? "Unknown Error")
            self?.delegate?.homeViewDataManagerHeaderEndRefreshing()
            self?.delegate?.homeViewDataManagerFooterEndRefreshing()
        })
    }
}
