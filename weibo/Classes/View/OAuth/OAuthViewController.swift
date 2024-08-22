//
//  OAuthViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/18.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
  
  private lazy var webView = UIWebView()
  
  @objc private func close() {
    dismiss(animated: true)
  }
  
  override func loadView() {
    view = webView
    webView.delegate = self
    title = "登录新浪微博"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(close))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    self.webView.loadRequest(URLRequest(url: NetworkTools.sharedTools.oauthUrl as URL))
  }
}


extension OAuthViewController: UIWebViewDelegate {
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
    guard let url = request.url, url.host == "www.baidu.com" else {
      return true
    }
    guard let query = url.query, query.hasPrefix("code=") else {
      print("取消授权")
      return false
    }
    let code = query.substring(from: "code=".endIndex)
    NetworkTools.sharedTools.loadAccessToken(code: code) { (result, error) in
      if error != nil {
        return
      }
      let account = UserAccount(dict: result as! [String: Any])
      self.loadUserInfo(account: account)
      
    }
    return false
  }
  private func loadUserInfo(account: UserAccount) {
    NetworkTools.sharedTools.loadUserInfo(token: account.access_token!, uid: account.uid) { result, error in
      if error != nil {
        print("加载用户失败")
        return
      }
      // result 一定有内容
      // 一定是字典
      guard let dict = result as? [String: Any] else {
        print("格式错误")
        return
      }
      account.screen_name = dict["screen_name"] as? String
      account.avatar_large = dict["avatar_large"] as? String
      self.title = account.screen_name
      print(account)
    }
  }
}
