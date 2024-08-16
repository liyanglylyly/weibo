//
//  DiscoverTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit

class DiscoverTableViewController: VisitorTableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    visitorView?.setupInfo(imageName: nil, title: "关注一些人, 回这里看看有什么惊喜")
  }
}
