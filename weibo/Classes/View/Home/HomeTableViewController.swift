//
//  HomeTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit

class HomeTableViewController: VisitorTableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    if !UserAccountViewModel.sharedUserAccount.userLogin {
      visitorView?.setupInfo(imageName: nil, title: "关注一些人, 回这里看看有什么惊喜")
      return
    }
    loadData()
  }
  
  // 加载数据
  private func loadData() {
    NetworkTools.sharedTools.loadStatus { result, error in
      if error != nil {
        print("出错了")
        return
      }
      print(result)
    }
  }
}
