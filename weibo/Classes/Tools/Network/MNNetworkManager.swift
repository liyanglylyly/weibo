//
//  NetworkTools.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestMethod{
  case GET
  case POST
}

class NetworkTools: AFHTTPSessionManager {
      
  static let sharedTools: NetworkTools = {
    let instance = NetworkTools(baseURL: nil)
    instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
    return instance
  }()
    
  //user account info
  lazy var userAccount = MNUserAccount()
    
  var isLogin: Bool {
    return userAccount.access_token != nil
  }
    
  //微博SDK 有各种问题可能导致登录不上，开发mock 数据的功能，点击`注册`按钮，可以mock本地数据
  var isLoadMockData: Bool = false
    
  /// AFNetwork request
  /// - Parameters:
  ///   - method: GET/POST
  ///   - URLString: url string
  ///   - parameters: parameters - [key:value]
  ///   - completion: (isSuccess, json)
  func request(method: RequestMethod = .GET, URLString: String, parameters: [String:AnyObject]?, completion: @escaping (_ isSuccess:Bool, _ json:Any?) -> ()) {
      
    let success = { (task: URLSessionDataTask, json: Any?) -> () in
      completion(true, json)
    }
    let failure = { (task: URLSessionDataTask?, error: Error) -> () in
      print("Request error ==> \(error)")
      if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
        print("token 过期了兄弟")
                
        //notification post message
        NotificationCenter.default.post(name: Notification.Name(MNUserShouldLoginNotification) , object: "token403")
      }
      completion(false, nil)
    }
    if method == .GET {
      get(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
    } else {
      post(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
    }
  }
    
  func tokenRequest(method: RequestMethod = .GET, URLString: String, parameters: [String:AnyObject]?, completion: @escaping (_ isSuccess:Bool, _ json:Any?) -> ()){
        
    guard let token = userAccount.access_token else {
      print("token is nil, need to login")
      NotificationCenter.default.post(name: Notification.Name(MNUserShouldLoginNotification) , object: nil)
      completion(false, nil)
      return
    }
        
    var parameters = parameters
    if parameters == nil {
      parameters = [String:AnyObject]()
    }
    //at this time, parameters must be valuable
    parameters!["access_token"] = token as AnyObject
    request(method: method, URLString: URLString, parameters: parameters, completion: completion)
  }
}

extension NetworkTools {
  var oauthURL: NSURL {
    let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_url=\(redirectUri)"
    return NSURL(string: urlString)!
  }
}
