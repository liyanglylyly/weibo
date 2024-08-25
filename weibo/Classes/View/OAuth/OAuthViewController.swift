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
      if !isSuccessed {
        print("失败了")
        return
      }
      // dismiss 不会立即将控制器销毁
      self.dismiss(animated: true) {
        // 完成控制器销毁之后再发送通知
        // 通知中心是同步的, 一旦发送通知, 会先执行监听方法, 直到结束后, 才执行后续代码
        NotificationCenter.default.post(name: NSNotification.Name(WBSwitchRootViewControllerNotifition), object: "welcome")
      }
    }
    return false
  }
}
