//
//  NetworkTools.swift
//  AFN_swift
//
//  Created by liyang on 2024/8/17.
//

import UIKit
import AFNetworking

enum RequestMethod: String {
  case GET = "GET"
  case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
  
  private let appKey = "951773789"
  private let appSecret = "7b0c3272d0e4ca476334d307445e9632"
  private let redirectUrl = "http://www.baidu.com"
  
  static let sharedTools: NetworkTools = {
    let tools = NetworkTools(baseURL: nil)
    tools.responseSerializer.acceptableContentTypes?.insert("text/html")
    return tools
  }()
}

extension NetworkTools {
  var oauthUrl: NSURL {
    let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
    return NSURL(string: urlString)!
  }
  func loadAccessToken(code: String, finished: @escaping (Any?, Error?) -> Void) {
    let urlString = "https://api.weibo.com/oauth2/access_token"
    let param = [
      "client_id": appKey,
      "client_secret": appSecret,
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": redirectUrl
    ]
    request(method: .POST, URLString: urlString, parameters: param, finished: finished)
  }
}

// MARK: - 封装 AFN 网络方法
extension NetworkTools {
  func request(method: RequestMethod, URLString: String, parameters: [String: Any]?, finished: @escaping (Any?, Error?) -> Void) {
    
    let success = { (task: URLSessionDataTask, result: Any) -> Void in
      finished(result, nil)
    }
    
    let failure = { (task: URLSessionDataTask, error: Error) -> Void in
      finished(nil, error)
    }
    
    if method == RequestMethod.GET {
      get(URLString, parameters: parameters, headers: nil, progress: nil, success: success) { task, error in
        finished(nil, error)
      }
    } else {
      post(URLString, parameters: parameters, headers: nil, progress: nil, success: success) { task, error in
        finished(nil, error)
      }
    }
    
//    if method == RequestMethod.GET {
//      get(URLString, parameters: parameters, headers: nil, progress: nil) { (_, res) -> Void in
//        finished(res as AnyObject, nil)
//      } failure: { (_, error) -> Void in
//        print(error)
//      }
//    } else if method == RequestMethod.POST {
//      post(URLString, parameters: parameters, headers: nil, progress: nil) { (_, res) -> Void in
//        finished(res as AnyObject, nil)
//      } failure: { _, error in
//        print(error)
//      }
//    }
  }
}
