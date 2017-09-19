//
//  TitleView.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

protocol TitleViewDelegate: class {
    func click(buttonTag:Int)
}

class TitleView: UIView {
    internal weak var delegate: TitleViewDelegate?
    
    internal weak var activeButton: UIButton?
    private weak var indicator: UIView?
    private weak var constraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(titles:[String], titleColor:UIColor, fontSize:CGFloat){
        self.init(frame: CGRect())
        
        var lastButton:UIButton?
        var tag = 0
        
        for title in titles {
            
            let button = UIButton(title: title, titleColor, fontSize)
            button.tag = tag
            button.addTarget(self, action: #selector(self.titleClick), for: .touchUpInside)
            self.addSubview(button)
            
            if let lastButton = lastButton {
                button.autoPinEdge(.leading, to: .trailing, of: lastButton)
                button.autoMatch(.width, to: .width, of: lastButton)
            }
            else {
                button.autoPinEdge(toSuperviewEdge: .leading)
                button.isEnabled = false
                activeButton = button
                
                let indicatorView = UIView()
                self.addSubview(indicatorView)
                indicatorView.backgroundColor = UIColor.red
                indicatorView.alpha = 0.8
                indicatorView.autoSetDimension(.height, toSize: 2.0)
                indicatorView.autoSetDimension(.width, toSize: 30)
                indicatorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
                constraint = indicatorView.autoAlignAxis(.vertical, toSameAxisOf: button)
                indicator = indicatorView
            }
            
            button.autoPinEdge(toSuperviewEdge: .bottom)
            button.autoPinEdge(toSuperviewEdge: .top)
            
            lastButton = button
            tag += 1
        }
        
        lastButton?.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    @objc func titleClick(button:UIButton) {
        activeButton?.isEnabled = true
        button.isEnabled = false
        activeButton = button
        constraint?.autoRemove()
        constraint = self.indicator?.autoAlignAxis(.vertical, toSameAxisOf: button)
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        delegate?.click(buttonTag: button.tag)
    }
}
