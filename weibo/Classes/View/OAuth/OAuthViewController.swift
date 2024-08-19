//
//  OAuthViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/18.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
  
  private lazy var webView = WKWebView()
  
  @objc private func close() {
    dismiss(animated: true)
  }
  
  override func loadView() {
    view = webView
    title = "登录新浪微博"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(close))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    self.webView.load(URLRequest(url: NetworkTools.sharedTools.oauthUrl as URL))
  }
}
