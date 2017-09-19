//
//  File.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    convenience init(title:String, _ titleColor:UIColor = UIColor.black,_ titleSize:CGFloat = 15.0) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.red, for: .disabled)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize)
    }
}
