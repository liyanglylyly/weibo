//
//  VisitorView.swift
//  weibo
//
//  Created by liyang on 2024/8/16.
//

import UIKit

/// 访客视图  - 处理用户未登录的界面显示
class VisitorView: UIView {
  
  
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
  private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
  private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
}

extension VisitorView {
  /// 设置界面
  private func setupUI() {
    // 1. 添加控件
    addSubview(iconView)
    addSubview(homeIconView)
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
  }
  
}
