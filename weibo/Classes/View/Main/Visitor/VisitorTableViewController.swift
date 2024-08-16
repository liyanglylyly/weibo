//
//  VisitorTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/16.
//

import UIKit

class VisitorTableViewController: UITableViewController {

  private var userLogin = false;
  var visitorView: VisitorView?
  
  override func loadView() {
    // 根据用户登录情况, 决定显示的根视图
    userLogin ? super.loadView() : setupVisitorView()
  }
  
  /// 设置访客视图
  private func setupVisitorView() {
    // 替换根视图
    visitorView = VisitorView()
    view = visitorView
  }

}
