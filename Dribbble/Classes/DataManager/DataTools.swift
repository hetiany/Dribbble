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
        page: Int,
        success: @escaping ([Shot]?) -> (),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        switch contentTpye {
        case .recent:
            print("recent")
            urlStr = shotsRecentEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accoutManager.accessToken!)
            break
            
        case .popular:
            print("popular")
            urlStr = shotsPopularEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accoutManager.accessToken!)
            break

        case .following:
            print("following")
            urlStr = shotsFollowingEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accoutManager.accessToken!)
            break

        case .debuts:
            print("debuts")
            urlStr = shotsDebutsEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accoutManager.accessToken!)
            break
            
        case .teams:
            print("teams")
            urlStr = shotsTeamsEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accoutManager.accessToken!)
            break
            
        case .playoffs:
            print("playoffs")
            urlStr = shotsPlayoffsEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accoutManager.accessToken!)
            break
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
