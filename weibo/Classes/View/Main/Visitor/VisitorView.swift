//
//  VisitorView.swift
//  weibo
//
//  Created by liyang on 2024/8/16.
//

import UIKit

/// 访客视图  - 处理用户未登录的界面显示
class VisitorView: UIView {
  
  @objc private func click() {
    print("xxx")
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
  
  private func setupUI() {
    let btn = UIButton(type: .contactAdd)
    addSubview(btn)
    btn.addTarget(self, action: #selector(click), for: .touchUpInside)
  }
  
}
