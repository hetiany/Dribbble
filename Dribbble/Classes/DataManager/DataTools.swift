//
//  DataTools.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

class DataTools {
    static let accountManager = AccountManager.shared
    
    //Fetch Shots
    static func fetchShots(
        contentTpye: ContentType,
        page: Int,
        success: @escaping ([Shot]?) -> (),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        switch contentTpye {
        case .recent:
            print("recent")
            urlStr = shotsRecentEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
            break
            
        case .popular:
            print("popular")
            urlStr = shotsPopularEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
            break

        case .following:
            print("following")
            urlStr = shotsFollowingEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
            break

        case .debuts:
            print("debuts")
            urlStr = shotsDebutsEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
            break
            
        case .teams:
            print("teams")
            urlStr = shotsTeamsEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
            break
            
        case .playoffs:
            print("playoffs")
            urlStr = shotsPlayoffsEndPoint.appending(pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
            break
        }
        
        //let urlStr = shotsPopularEndPoint.appending(accessParameter + accountManager.accessToken!)
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
    
    //Fetch Comments
    static func fetchComment(
        page: Int,
        id: Int,
        success: @escaping ([Comment]?) -> (),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        urlStr = base.appending( "shots/" + String(id) + "/comments?" + pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
        
        HTTPTools.get(urlStr: urlStr, success: { (any) in
            
            if let any = any {
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let object = any as? [Any] {
                    var res: [Comment] = []
                    
                    for i in 0..<object.count {
                        guard let dict = object[i] as? [String: Any] else {
                            return
                        }
                        guard let model = Comment(JSON: dict) else {
                            return
                        }
                        res.append(model)
                    }
                    success(res)
                } else {
                    print("JSON is invalid")
                    success(nil)
                }
            } else {
                success(nil)
            }
            
        }, failure: {
            (error) in
            failure(error)
        })
    }
    
    //Fetch Users
    static func fetchUser(
        page: Int,
        userId: Int,
        success: @escaping (User?) ->(),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        urlStr = base.appending( "users/" + String(userId) + "?" + pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
        
        HTTPTools.get(urlStr: urlStr, success: { (any) in
            
            if let any = any {
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    var res: User?
                    guard let dict = any as? [String: Any] else {
                        return
                    }
                    guard let model = User(JSON: dict) else {
                        return
                    }
                    res = model
                    guard let result = res else {
                        return
                    }
                    success(result)
                } else {
                    print("JSON is invalid")
                    success(nil)
                }
        }, failure: {
            (error) in
            failure(error)
        })
    }
    
    // Fetch User Shots
    static func fetchUserShots(
        page: Int,
        url: String,
        success: @escaping ([Shot]?) -> (),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        urlStr = url + "?" + pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!
            
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
    
    
    
    //Fetch Authenticated User
    static func fetchAuthUser(
        page: Int,
        success: @escaping (User?) ->(),
        failure: @escaping (Error?) -> ()) {
        
        var urlStr: String = ""
        urlStr = base.appending( "user" + "?" + pageParameter + String(page) + "&" + accessParameter + accountManager.accessToken!)
        
        HTTPTools.get(urlStr: urlStr, success: { (any) in
            
            if let any = any {
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                var res: User?
                guard let dict = any as? [String: Any] else {
                    return
                }
                guard let model = User(JSON: dict) else {
                    return
                }
                res = model
                guard let result = res else {
                    return
                }
                success(result)
            } else {
                print("JSON is invalid")
                success(nil)
            }
        }, failure: {
            (error) in
            failure(error)
        })
    }
}
