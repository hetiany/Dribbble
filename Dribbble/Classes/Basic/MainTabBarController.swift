
//
//  MainTabBarControllerViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/5/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit
import PureLayout

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
        setupTabBarBackground()
    }
}

fileprivate typealias Utilities = MainTabBarController
fileprivate extension Utilities {
    
    func setupChildViewController() {
        let vc1 = HomeViewController(contentType: .recent)
        //let label = UILabel()
//        label.text = "VC1"
//        vc1.view.addSubview(label)
//        vc1.view.backgroundColor = UIColor.yellow
//        label.autoPinEdgesToSuperviewEdges()
        //vc1.title = "Recent"
        
        let vc2 = HomeViewController(contentType: .popular)
        //let label2 = UILabel()
        //label2.text = "VC2"
        //vc2.view.addSubview(label2)
        //vc2.view.backgroundColor = UIColor.red
        //label2.autoPinEdgesToSuperviewEdges()
        //vc2.title = "Popular"
        setupChildVC(TitleMenuViewController(style: .menu, childVC: [vc1, vc2]), "home")
        
        
        
//        let vc3 = UIViewController()
//        vc3.view.backgroundColor = UIColor.red
//        vc3.title = "Following"
//        
//        let vc4 = UIViewController()
//        vc4.view.backgroundColor = UIColor.blue
//        vc4.title = "Debuts"
//        
//        let vc5 = UIViewController()
//        vc5.view.backgroundColor = UIColor.yellow
//        vc5.title = "Teams"
//        
//        let vc6 = UIViewController()
//        vc6.view.backgroundColor = UIColor.red
//        vc6.title = "Playoffs"
        let vc3 = ExploreViewController(contentType: .following)
        let vc4 = ExploreViewController(contentType: .debuts)
        let vc5 = ExploreViewController(contentType: .teams)
        let vc6 = ExploreViewController(contentType: .playoffs)
        setupChildVC(TitleMenuViewController(style: .subMenu, childVC: [vc3, vc4, vc5, vc6]), "explore")
        
        setupChildVC(PortfolioViewController(), "user")
    }

    private func setupChildVC(_ vc: UIViewController, _ imageStr: String) {
        vc.tabBarItem.image = UIImage(named: imageStr)
        vc.tabBarItem.selectedImage = UIImage(named: imageStr + "-click")
        
        
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let nav = NavigationController(rootViewController: vc)
        self.addChildViewController(nav)
        
    }
    
    func setupTabBarBackground() {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let color = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.95)
        

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.backgroundImage = image
    }

}
