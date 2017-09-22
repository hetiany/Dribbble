//
//  WKViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/18/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import UIKit
import WebKit

protocol WKViewControllerDelegate: class {
    func WKViewDidFinish()
    func WKViewDidFail()
    func WKViewDidDone()
    func WKViewDidReceivedCallback(url: URL)
}

class WKViewController: UIViewController {
    
    // MARK: - Model
    var url: URL?
    
    // MARK: - View
    var webview = WKWebView()
    var btnDone = UIBarButtonItem()
    var progBar = UIProgressView()
    
    
    // MARK: - delegate
    weak var webViewDelegate: WKViewControllerDelegate?
    
    // MARL: - Constants
    //let progressKey = "estimatedProgress"
        
    // MARK: - Init
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //removeProgressKVO()
    }
}

extension WKViewController: WKNavigationDelegate {
    
    //MARK: - WKNavigationDelegate
    // finish loading url
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("wkVC: didFinish WKWebView")
        self.navigationItem.title = "Sign in to Dribbble"
        webViewDelegate?.WKViewDidFinish()
        
    }
    
    // fail to load url
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("wkVC: didFail WKWebView")
        print("wkVC: error: \(error)")
        webViewDelegate?.WKViewDidFail()
    }
    
    // handle callBack scheme
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        if let urlScheme = url?.scheme,
            urlScheme == AccountManager.Keys.callBackUrl,
            let validURL = url {
            
            self.webViewDelegate?.WKViewDidReceivedCallback(url: validURL)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
}


extension WKViewController {
    func prepareView() {
        let origin = CGPoint(x: 0, y: 0)
        let size = self.view.frame.size
        webview.frame = CGRect(origin: origin, size: size)
        
        // creat web request
        print("wkVC: viewDidLoad")
        if let validURL = url {
            let request = URLRequest(url: validURL)
            // load request
            webview.load(request)
            // add wkwebview as subView
            self.view.addSubview(webview)
        }
        webview.navigationDelegate = self

        
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        //self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        //self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // limit frame of webview
        //self.navigationController?.navigationBar.isTranslucent = true
        
        btnDone = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(WKViewController.toDone)
        )
        self.navigationItem.rightBarButtonItem = btnDone
        
        
        // init progress
        //initLoadingProgress()
    }
    
    func toDone() {
        print("wkVC: toDone")
        _ = self.navigationController?.popViewController(animated: false)
    }
}

// MARK: - loading progress
extension WKViewController {
    
//    // init in didLoad
//    func initLoadingProgress() {
//        let origin = CGPoint(x: 0, y: 0)
//        let size = CGSize(width: self.view.frame.width, height: 50)
//        let frame = CGRect(origin: origin, size: size)
//        progBar = UIProgressView(frame: frame)
//        progBar.progress = 0.0
//        progBar.tintColor = UIColor.red
//        self.webview.addSubview(progBar)
//        
//        // addKVO
//        addKVO()
//    }
//    
//    // MARK: - handle KVO
//    //The WKWebView class is key-value observing (KVO) compliant for this property.
//    
//    // addKVO in didLoad
//    func addKVO() {
//        self.webview.addObserver(
//            self,
//            forKeyPath: progressKey,
//            options: NSKeyValueObservingOptions.new,
//            context: nil
//        )
//    }
//    
//    func removeProgressKVO() {
//        self.webview.removeObserver(self, forKeyPath: progressKey)
//    }
//    
//    override func observeValue(
//        forKeyPath keyPath: String?,
//        of object: Any?,
//        change: [NSKeyValueChangeKey : Any]?,
//        context: UnsafeMutableRawPointer?
//        ) {
//        if keyPath == progressKey {
//            self.progBar.alpha = 1.0
//            let estiProgress = Float(webview.estimatedProgress)
//            progBar.setProgress(estiProgress, animated: true)
//            //max progress value: 1.0
//            if estiProgress >= 1.0 {
//                UIView.animate(
//                    withDuration: 0.5,
//                    delay: 0.3,
//                    options: UIViewAnimationOptions.curveEaseInOut,
//                    animations: { () -> Void in
//                        self.progBar.alpha = 0.0
//                },
//                    completion: { (finished:Bool) -> Void in
//                        self.progBar.progress = 0.0
//                }
//                )
//            }
//        }
//    }
}
