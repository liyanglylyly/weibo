//
//  MainViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit

class MainViewController: UITabBarController {
  // MARK: - 监听方法
  // 点击撰写按钮
  @objc private func clickComposedButton() {
    print("xxx")
  }
  
  // MARK: - 视图声明周期函数
  override func viewDidLoad() {
    super.viewDidLoad()
    addChildViewControllers()
    setComposeButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated);
    tabBar.bringSubviewToFront(composeButton)
  }
  
  // MARK: - 懒加载控件
  private lazy var composeButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
//  {
//    // 自定义样式的按钮
//    let button = UIButton();
//    button.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal);
//    button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted);
//    button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal);
//    button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
//    button.sizeToFit()
//    return button
//  }()
  
}

// MARK: - 设置界面
extension MainViewController {
  
  // 设置撰写按钮
  private func setComposeButton() {
    // 1. 添加按钮
    tabBar.addSubview(composeButton);
    // 2. 调整位置
    let count = children.count
    // 让按钮宽一点， 能够解决按钮触摸的容错问题
    let w = tabBar.bounds.size.width / CGFloat(count) - 1
    composeButton.frame = CGRectInset(tabBar.bounds, 2 * w, 0);
    // 3. 添加监听方法
    composeButton.addTarget(self, action: #selector(clickComposedButton), for: .touchUpInside)
  }
  
  private func addChildViewControllers() {
    addChildViewController(vc: HomeTableViewController(), title: "首页", imageName: "tabbar_home");
    addChildViewController(vc: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center");
    addChild(UIViewController())
    addChildViewController(vc: DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover");
    addChildViewController(vc: ProfileTableViewController(), title: "我", imageName: "tabbar_profile");
    
  }
  
  // 添加控制器
  private func addChildViewController(vc: UIViewController, title: String, imageName: String) {
    vc.title = title
    vc.tabBarItem.image = UIImage(named: imageName)
    let nav = UINavigationController(rootViewController: vc)
    addChild(nav)
  }
}
