//
//  VisitorView.swift
//  weibo
//
//  Created by liyang on 2024/8/16.
//

import UIKit
import SnapKit

/// 访客视图  - 处理用户未登录的界面显示
class VisitorView: UIView {
    
  
  // MARK: - 设置视图信息
  func setupInfo(imageName: String?, title: String) {
    messageLabel.text = title
    // 如果imageName 为 nil, 说明是首页, 直接返回
    guard let imgName = imageName else {
      // 播放动画
      startAnim()
      return
    }
    iconView.image = UIImage(named: imgName)
    // 隐藏小房子
    homeIconView.isHidden = true
    // 将遮罩图像移动到底层
    sendSubviewToBack(maskIconView)
  }
  
  // 开启首页轮转动画
  private func startAnim() {
    let anim = CABasicAnimation(keyPath: "transform.rotation")
    anim.toValue = 2 * Double.pi
    anim.repeatCount = MAXFLOAT
    anim.duration = 20
    
    anim.isRemovedOnCompletion = false
    // 添加到图层
    iconView.layer.add(anim, forKey: nil)
  }
  
  // initWithFrame 是UIView指定的构造函数
  // 使用纯代码开发的入口
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  // initWithCoder - 使用 SB & XIB 开发加载的函数
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  // MARK: - 懒加载控件
  private lazy var iconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
  private lazy var maskIconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
  private lazy var homeIconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")
  private lazy var messageLabel: UILabel = UILabel(title: "关注一些人, 回这里看看有什么惊喜")
  lazy var registerButton: UIButton = UIButton(title: "注册", color: UIColor.orange, backImageName: "common_button_white_disable")
  lazy var loginButton: UIButton = UIButton(title: "登录", color: UIColor.darkGray, backImageName: "common_button_white_disable")
}

extension VisitorView {
  /// 设置界面
  private func setupUI() {
    // 1. 添加控件
    addSubview(iconView)
    addSubview(maskIconView)
    addSubview(homeIconView)
    addSubview(messageLabel)
    addSubview(registerButton)
    addSubview(loginButton)
    // 2. 设置自动布局
    iconView.snp_makeConstraints { make in
      make.centerX.equalTo(self.snp_centerX)
      make.centerY.equalTo(self.snp_centerY).offset(-60)
    }
    
    // 2 > 小房子
    homeIconView.snp_makeConstraints { make in
      make.center.equalTo(iconView.snp_center)
    }
    
    // 3 > 消息文字
    messageLabel.snp_makeConstraints { make in
      make.centerX.equalTo(iconView.snp_centerX)
      make.top.equalTo(iconView.snp_bottom).offset(16)
      make.width.equalTo(224)
      make.height.equalTo(36)
    }

    // 4 > 注册按钮
    registerButton.snp_makeConstraints { make in
      make.left.equalTo(messageLabel.snp_left)
      make.top.equalTo(messageLabel.snp_bottom).offset(16)
      make.width.equalTo(100)
      make.height.equalTo(36)
    }

    // 5 > 登录按钮
    loginButton.snp_makeConstraints { make in
      make.right.equalTo(messageLabel.snp_right)
      make.top.equalTo(registerButton.snp_top)
      make.width.equalTo(registerButton.snp_width)
      make.height.equalTo(registerButton.snp_height)
    }

    // 6 > 遮罩层
    maskIconView.snp_makeConstraints { make in
      make.top.equalTo(self.snp_top)
      make.left.equalTo(self.snp_left)
      make.bottom.equalTo(registerButton.snp_bottom)
      make.right.equalTo(self.snp_right)
    }
    // 设置背景颜色
    backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
    
  }
  
}
