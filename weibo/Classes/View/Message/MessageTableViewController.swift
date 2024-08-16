//
//  MessageTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit

class MessageTableViewController: VisitorTableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    visitorView?.setupInfo(imageName: "visitordiscover_image_message", title: "关注一些人, 回这里看看有什么惊喜")
  }
}
