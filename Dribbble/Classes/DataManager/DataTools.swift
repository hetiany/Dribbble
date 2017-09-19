//
//  DataTools.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

class DataTools {
    
    static func fetchShots(
        success: @escaping ([Shot]?) -> (),
        failure: @escaping (Error?) -> ()) {
        let urlStr = shotsEndPoint.appending(accessParameter + accessToken)
        HTTPTools.get(urlStr: urlStr, success: { (any) in
//            guard let data = data else {
//                return
//            }
//
//            guard let objs = try? JSONSerialization.jsonObject(with: data, options: []) else {
//                assertionFailure("[Shot] : cannot serialize")
//                return
//            }
//
//            guard let validObjs = objs as? [Any] else {
//                assertionFailure("[Shot] : is not [Any]")
//                return
//            }
//            var res: [Shot] = []
//            for obj in validObjs {
//                if let shot = Shot(input: obj) {
//                    res.append(shot)
//                }
//            }
            
            if let any = any {
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let object = any as? [Any] {
                    var res: [Shot] = []
                    
//                    object.forEach({ (element) in
//                        guard let dict = element as? [String: Any] else {
//                            return
//                        }
//                        guard let model = Shot(JSON: dict, context: nil) else {
//                            return
//                        }
//                        res.append(model)
//                    })
                    
                    for i in 0..<object.count {
                        guard let dict = object[i] as? [String: Any] else {
                            return
                        }
                        guard let model = Shot(JSON: dict) else {
                            return
                        }
                        res.append(model)
                    }
//                    print(res.count)
                    success(res)
                } else {
                    print("JSON is invalid")
                }
            }
            
//            print(validObjs)
//            print(validObjs.count)
//            success(nil)
        }, failure: {
            (error) in
            failure(error)
        })
    }
}
