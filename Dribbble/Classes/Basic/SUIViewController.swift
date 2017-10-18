//
//  SUIViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/14/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class SUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
