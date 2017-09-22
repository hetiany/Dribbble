//
//  LoginViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/18/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import PureLayout
import WebKit


class LoginViewController: UIViewController {

    fileprivate let accountManager = AccountManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .white
        accountManager.delegate = self
        
        let loginButton = UIButton()
        //loginButton.setTitleColor(UIColor.darkGray, for: .normal)
        loginButton.setTitle("Login with Dribbble", for: .normal)
        loginButton.addTarget(self, action: #selector(self.didTapLoginButton), for: .touchUpInside)
        view.addSubview(loginButton)
    
        loginButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    @objc func didTapLoginButton() {
        if accountManager.hasAccessToken == false {
            
            let authUrl = accountManager.oauth2LoginUrl
            let wkVC = WKViewController(url: authUrl)
            wkVC.webViewDelegate = self
            
            self.navigationController?.pushViewController(wkVC, animated: true)
        }
        else {
            print("has login")
        }
    }
    
}

// MARK: - AccountManagerDelegate
extension LoginViewController: AccountManagerDelegate {
    func didFinishOAuthFlow(success: Bool, error: Error?) {
        if let error = error {
            assertionFailure(error.localizedDescription)
        }
        else if success {
            let tabBarVC = MainTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        }
        else {
            print("Fail to login")
        }
    }
}

extension LoginViewController: WKViewControllerDelegate {
    func WKViewDidFinish() {
        accountManager.clearRequestingOAuth()
    }
    
    func WKViewDidFail() {
        accountManager.clearRequestingOAuth()
    }
    
    func WKViewDidDone() {
        accountManager.clearRequestingOAuth()
    }
    
    func WKViewDidReceivedCallback(url: URL) {
        accountManager.handleCallBack(url: url)
    }
}



