//
//  ShotDetailViewController.swift
//  Dribbble
//
//  Created by Hetian Yang on 10/2/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import UIKit

class ShotDetailViewController: UIViewController {

    var shotTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        // Do any additional setup after loading the view.
    }

}

extension ShotDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


extension ShotDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

fileprivate typealias Utilities = ShotDetailViewController
fileprivate extension Utilities {
    
    func prepareTableView() {
        
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        shotTableView = tableView
        
        

    }
}


