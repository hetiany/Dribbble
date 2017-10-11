//
//  UserProfileViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/2/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class PlayerProfileViewController: UIViewController {
    
    fileprivate var playerCollectionView: UICollectionView?
    
    fileprivate let playerShotSummaryId = "PlayerShotSummaryView"
    fileprivate let playerShotViewId = "PlayerShotViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        // Do any additional setup after loading the view.
    }

}

extension PlayerProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playerShotViewId, for: indexPath) as! PlayerShotViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: playerShotSummaryId, for: indexPath) as! PlayerShotSummaryView
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
        
        print("ScreenWidth is \(ScreenWidth)")
        print("ScreenHeight is \(ScreenHeight)")
        
        print("itemWidth is \(itemWidth)")
        print("itemHeight is \(itemHeight)")
        
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
}
