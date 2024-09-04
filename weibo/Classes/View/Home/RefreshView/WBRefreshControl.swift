//
//  WBRefreshControl.swift
//  weibo
//
//  Created by liyang on 2024/9/4.
//

import UIKit

/// 自定义刷新控件 - 负责处理刷新逻辑
class WBRefreshControl: UIRefreshControl {
  override init() {
    super.init()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  private func setupUI() {
    addSubview(refreshView)
    refreshView.backgroundColor = UIColor.red
    //
    refreshView.snp_makeConstraints { make in
      make.centerX.equalTo(self.snp_centerX)
      make.centerY.equalTo(self.snp_centerY)
      make.size.equalTo(refreshView.bounds.size)
    }
  }
  
  // MARK: - 懒加载控件
  private lazy var refreshView = WBRefreshView.refreshView()
}


/// 刷新视图 - 负责处理动画显示
class WBRefreshView: UIView {
  /// 从XIB加载视图 类函数
  class func refreshView() -> WBRefreshView {
    let nib = UINib(nibName: "WBRefreshView", bundle: nil)
    return nib.instantiate(withOwner: nil)[0] as! WBRefreshView
  }
}
