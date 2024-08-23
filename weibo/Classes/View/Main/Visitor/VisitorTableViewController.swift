//
//  VisitorTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/16.
//

import UIKit

class VisitorTableViewController: UITableViewController {

  private var userLogin = UserAccountViewModel().userLogin
  var visitorView: VisitorView?
  
  override func loadView() {
    // 根据用户登录情况, 决定显示的根视图
    userLogin ? super.loadView() : setupVisitorView()
  }
  
  /// 设置访客视图
  private func setupVisitorView() {
    // 替换根视图
    visitorView = VisitorView()
    visitorView?.loginButton.addTarget(self, action: #selector(visitorViewDidLogin), for: .touchUpInside)
    visitorView?.registerButton.addTarget(self, action: #selector(visitorViewRegister), for: .touchUpInside)
    view = visitorView
    
    // 设置导航栏按钮
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(visitorViewRegister))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(visitorViewDidLogin))
  }

}

// MARK: - 访客视图监听方法
extension VisitorTableViewController {
  @objc func visitorViewRegister() {
    print("11")
  }
  
  @objc func visitorViewDidLogin() {
    let vc = OAuthViewController()
    vc.modalPresentationStyle = .fullScreen
    let nav = UINavigationController(rootViewController: vc)
    present(nav, animated: true)
    
  }
}
