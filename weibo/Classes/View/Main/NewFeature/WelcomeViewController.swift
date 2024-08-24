//
//  WelcomeViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/24.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  override func loadView() {
    view = backImageView
    setupUI()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  /**
   *  使用自动布局开发, 有一个原则:
   *    - 所有使用约束设置位置的控件，不要再设置 frame
   *    - 原因: 自动布局系统会根据设置的约束，自动计算控件的frame
   *    -  在 layoutSubviews 函数中设置 frame
   *    - 工作原理: 当有一个运行循环启动, 自动布局系统会收集所有的约束变化
   *    - 在运行循环结束前，调用 layoutSubviews 函数统一设置 frame
   *    -  如果希望某些约束提前更新 使用 layoutIfNeeded 函数让自动布局系统提前更新当前收集到的约束变化
   */
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // 1. 更改约束 -> 改变位置
    iconView.snp_updateConstraints { make -> Void in
      make.bottom.equalTo(view.snp_bottom).offset(-view.bounds.height + 200)
    }
    
    // 2. 动画
    welcomeLabel.alpha = 0
    UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: []) {
      // 自动布局动画
      self.view.layoutIfNeeded()
    } completion: { _ in
      UIView.animate(withDuration: 0.8) {
        self.welcomeLabel.alpha = 1
      } completion: { _ in
        
      }

    }

  }
  
  // MARK: - 懒加载控件
  private lazy var backImageView: UIImageView = UIImageView(imageName: "ad_background")
  private lazy var iconView: UIImageView = {
    let iv = UIImageView(imageName: "avatar_default_big")
    iv.layer.cornerRadius = 45
    iv.layer.masksToBounds = true
    return iv
  }()
  private lazy var welcomeLabel: UILabel = UILabel(title: "欢迎归来", fontSize: 18)

}

// MARK: - 设置界面
extension WelcomeViewController {
  private func setupUI() {
    view.addSubview(iconView)
    view.addSubview(welcomeLabel)
    iconView.snp_makeConstraints { make in
      make.centerX.equalTo(view.snp_centerX)
      make.bottom.equalTo(view.snp_bottom).offset(-200)
      make.width.equalTo(90)
      make.height.equalTo(90)
    }
    welcomeLabel.snp_makeConstraints { make in
      make.centerX.equalTo(iconView.snp_centerX)
      make.top.equalTo(iconView.snp_bottom).offset(16)
    }
  }
}
