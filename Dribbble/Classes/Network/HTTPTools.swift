//
//  HTTPTools.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation
import Alamofire

class HTTPTools {
    static func get(
        urlStr: String,
        parameters: [String: Any]? = nil,
        success: @escaping (Any?) -> (),
        failure: @escaping (Error?) -> ()) {
        
        //print(urlStr)
        guard let url = URL(string: urlStr) else {
            return
        }
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                //print(response.result.value)
                success(response.result.value)
            } else {
                failure(response.result.error)
            }
        }

//        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {
//            (response) in
//            if response.result.isSuccess {
//                print(response.result.value)
//                //success(response.result.value)
//            } else {
//                failure(response.result.error)
//            }
//        })
        
//        let dataRequest = Alamofire.SessionManager.default.request(url)
//        dataRequest.responseJSON { (result) in
//            guard let json = result.value else {
//                return
//            }
//            //print(json)
//        }
        
    }
    

    static func post(
        urlStr: String,
        parameters: [String: Any]? = nil,
        header: [String: Any]? = nil,
        completion: @escaping (String?, Error?) -> ()) {
        
        //print(urlStr)
        guard let url = URL(string: urlStr) else {
            return
        }
        
        Alamofire.request(url, method: .post, parameters: parameters).responseString { (response) in
            if response.result.isSuccess {
                //print(response.result.value)
                //success(response.result.value)
                completion(response.result.value, nil)
            } else {
                completion(nil, response.result.error)
            }
        }
    }
    
    
}
