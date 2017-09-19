//
//  UIView+Size.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
}
