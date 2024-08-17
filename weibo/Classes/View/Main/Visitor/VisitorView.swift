//
//  VisitorView.swift
//  weibo
//
//  Created by liyang on 2024/8/16.
//

import UIKit

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
  lazy var registerButton: UIButton = UIButton(title: "注册", color: UIColor.orange, imageName: "common_button_white_disable")
  lazy var loginButton: UIButton = UIButton(title: "登录", color: UIColor.darkGray, imageName: "common_button_white_disable")
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
    // 添加约束需要添加到父视图上
    // 建议，子视图最好有一个统一的参照物
    // translatesAutoresizingMaskIntoConstraints 默认值为true， 支持使用setFrame的方式来设置控件位置
    // translatesAutoresizingMaskIntoConstraints 设置为false，支持使用自动布局来设置控件位置
    for v in subviews {
      v.translatesAutoresizingMaskIntoConstraints = false
    }
    //    iconView.translatesAutoresizingMaskIntoConstraints = false
    //    homeIconView.translatesAutoresizingMaskIntoConstraints = false
    // 1 > 图标
    addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0));
    addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0));
    // 2 > 小房子
    addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0));
    addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0));
    // 3 > 消息文字
    addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
    addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
    addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
    // 4 > 注册按钮
    addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
    addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
    addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
    // 5 > 登录按钮
    addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
    addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
    addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
    // 6 > 遮罩层
    // VFL: 可视化格式语言
    // V: 垂直方向
    // H: 水平方向
    // ｜: 边界
    // views: 字典 [名字: 控件名] - VFL 字符串中表示控件的字符串
    // metrics: 字典 [名字: NSNumber] - VFL 字符串中表示某一个数值
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", metrics: nil, views: ["mask": maskIconView]))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", metrics: ["btnHeight": -36], views: ["mask": maskIconView, "regButton": registerButton]))
    // 设置背景颜色
    backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
    
  }
  
}
