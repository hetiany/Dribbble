//
//  DataTools.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

class DataTools {
    static let accoutManager = AccountManager.shared
    static func fetchShots(
        contentTpye: ContentType,
        success: @escaping ([Shot]?) -> (),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        switch contentTpye {
        case .popular:
            print("popular")
            urlStr = shotsPopularEndPoint.appending(accessParameter + accoutManager.accessToken!)
            break
            
        case .recent:
            print("recent")
            urlStr = shotsRecentEndPoint.appending(accessParameter + accoutManager.accessToken!)
            break
            
//        case .following:
//            
//        case .debuts:
//            
//        case .teams:
//            
//        case .playoffs:
        default:
            print("OK")
        }
        
        //let urlStr = shotsPopularEndPoint.appending(accessParameter + accoutManager.accessToken!)
        HTTPTools.get(urlStr: urlStr, success: { (any) in
            
            if let any = any {
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let object = any as? [Any] {
                    var res: [Shot] = []
                    
                    for i in 0..<object.count {
                        guard let dict = object[i] as? [String: Any] else {
                            return
                        }
                        guard let model = Shot(JSON: dict) else {
                            return
                        }
                        res.append(model)
                    }
                    success(res)
                } else {
                    print("JSON is invalid")
                }
            }
        }, failure: {
            (error) in
            failure(error)
        })
    }
}
