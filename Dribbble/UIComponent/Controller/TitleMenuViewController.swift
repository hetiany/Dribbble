//
//  TitleMenuViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class TitleMenuViewController: SUIViewController {

        public enum MenuStyle {
            case menu
            case subMenu
            
            var titleColor: UIColor {
                switch self {
                case .menu:
                    return UIColor.black
                case .subMenu:
                    return UIColor.red
                }
            }
            var fontSize: CGFloat {
                switch self {
                case .menu:
                    return 16
                case .subMenu:
                    return 18
                }
            }
        }
        fileprivate lazy var menuStyle: MenuStyle = .subMenu
        
        
        fileprivate var titlesView: TitleView!
        fileprivate weak var contentView: UIScrollView?
        
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
    
        convenience init(style: MenuStyle, childVC: [UIViewController]) {
            self.init()
            var titles:[String] = []
            
            for vc in childVC {
                titles.append(vc.title ?? "null")
                self.addChildViewController(vc)
            }
            self.menuStyle = style
            
            titlesView = TitleView(titles: titles, titleColor: style.titleColor, fontSize: style.fontSize)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            prepareUI()
        }
}


fileprivate typealias Utilities = TitleMenuViewController
fileprivate extension Utilities {
    func prepareUI() {
        setupTitlesView()
        setupContentView()
        setupAutoLayout()
        //setupSubViews()
    }
    
    private func setupTitlesView() {
        self.titlesView.delegate = self
        switch menuStyle {
        case .menu:
            self.navigationItem.titleView = titlesView
        case .subMenu:
            self.view.addSubview(titlesView)
            titlesView.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.9)
        }
        
        
    }
    private func setupContentView() {
        self.automaticallyAdjustsScrollViewInsets = false
        let contentView = UIScrollView(frame: self.view.bounds)
        contentView.isPagingEnabled = true
        
        self.view.insertSubview(contentView, at: 0)
        //print(self.view.bounds.size.width)
        //print(self.view.bounds.size.height)
    
        
        contentView.contentSize = CGSize(width: self.view.bounds.size.width*CGFloat(self.childViewControllers.count), height: 0)
        
        contentView.frame = self.view.frame
        
        contentView.delegate = self
        
        //self.view.addSubview(contentView)
        self.contentView = contentView
        
        self.scrollViewDidEndScrollingAnimation(contentView)
    }
    
    private func setupAutoLayout() {
        switch menuStyle {
        case .menu:
            titlesView.autoPinEdge(toSuperviewEdge: .top)
            titlesView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
            titlesView.autoSetDimension(.width, toSize: 200.0)
        case .subMenu:
            titlesView.autoSetDimension(.height, toSize: 40)
            titlesView.autoPinEdge(toSuperviewEdge: .leading)
            titlesView.autoPinEdge(toSuperviewEdge: .trailing)
            titlesView.autoPinEdge(toSuperviewEdge: .top, withInset: 64)
        }
    }
    
//    private func setupSubViews() {
//        var i = 0
//        self.childViewControllers.forEach { (vc) in
//            self.contentView?.addSubview(vc.view)
//            vc.view.x = CGFloat(i) * UIScreen.main.bounds.size.width
//            i += 1
//        }
//    }
}


private typealias ScrollDelegate = TitleMenuViewController
extension ScrollDelegate: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = (Int)(scrollView.contentOffset.x/scrollView.bounds.size.width)
        
        //print(Int(contentView?.contentSize.width ?? CGFloat(13)))
        
        //print("scrollview bounds width\(scrollView.bounds.size.width)")
        //print("scrollView contentoffset\(scrollView.contentOffset.x)")
        //print("UIScreen width\(UIScreen.main.bounds.size.width)")
        //let index = (Int)(scrollView.contentOffset.x/UIScreen.main.bounds.size.width)
        
        let vc = self.childViewControllers[index]
        //print(vc.view.x)
        
        vc.view.x = scrollView.contentOffset.x
        print(scrollView.contentOffset.x)
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
        
        var index = (Int)(scrollView.contentOffset.x / scrollView.bounds.size.width)
        if index >= 1 {
            index += 1 // consider indicator of titlesView
        }
        guard let button = self.titlesView.subviews[index] as? UIButton else {
            assertionFailure("Should convert to button")
            return
        }
        titlesView.titleClick(button: button)
    }
    
}

private typealias TitleViewTool = TitleMenuViewController
extension TitleViewTool: TitleViewDelegate {
    func click(buttonTag:Int) {
        var offset = self.contentView?.contentOffset
        offset?.x = CGFloat(buttonTag) * self.view.bounds.width
        self.contentView?.setContentOffset(offset!, animated: true)
    }
}

