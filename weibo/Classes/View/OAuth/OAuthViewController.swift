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
    UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code) { isSuccessed in
      if isSuccessed {
        print("成功了")
        self.dismiss(animated: true)
      } else {
        print("失败了")
      }
    }
    return false
  }
}
