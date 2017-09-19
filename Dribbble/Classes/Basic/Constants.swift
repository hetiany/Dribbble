//
//  Constants.swift
//  Dribbble
//
//  Created by Hetian Yang on 9/6/17.
//  Copyright © 2017 Hetian Yang. All rights reserved.
//

import Foundation

//let accessToken = "37ddfc23b82ae5cfc673bc92770caf17272407d0d07bce3c1840fc993a509667"
let accessToken = "a156d6134f4a70f744b0215d74890e0f38e9c60f1d08a80e5c69c900a8aa006f"
let accessParameter = "?access_token="

let base = "https://api.dribbble.com/v1/"
let authUrl = "https://dribbble.com/oauth/authorize"
let tokenUrl = "https://dribbble.com/oauth/token"
let redirectUrl = "http://www.google.com/"

let shotsEndPoint = "https://api.dribbble.com/v1/shots"

let userEndPoint = "https://api.dribbble.com/v1/user"
let usersEndPoint = "https://api.dribbble.com/v1/users"
let followShotEndPoint = "https://api.dribbble.com/v1/user/following/shots"


let ReceivedURLCallBackNotification = NSNotification.Name(rawValue: "kReceivedURLCallBackNotification")
