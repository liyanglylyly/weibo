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
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
        // Do any additional setup after loading the view.
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
      make.bottom.equalTo(view.snp_bottom).multipliedBy(0.7)
      make.width.equalTo(90)
      make.height.equalTo(90)
    }
    welcomeLabel.snp_makeConstraints { make in
      make.centerX.equalTo(iconView.snp_centerX)
      make.top.equalTo(iconView.snp_bottom).offset(16)
    }
  }
}
