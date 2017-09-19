//
//  PortfolioViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import WebKit

class PortfolioViewController: SUIViewController {

    fileprivate let accountManager = AccountManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.didTapLogout))
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
                         WKWebsiteDataTypeIndexedDBDatabases]
        let dataTypeSet = Set(dataTypes)
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypeSet, modifiedSince: Date.distantPast, completionHandler: {
            print("clear ok")
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        })
    }
}
