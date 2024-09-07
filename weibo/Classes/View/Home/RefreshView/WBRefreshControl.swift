//
//  WBRefreshControl.swift
//  weibo
//
//  Created by liyang on 2024/9/4.
//

import UIKit

private let WBRefreshControlOffset: CGFloat = -60
/// 自定义刷新控件 - 负责处理刷新逻辑
class WBRefreshControl: UIRefreshControl {
  
  
  private var rotateFlag = false
  
  // MARK: - KVO监听方法
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    print("KVO = \(frame)")
    if frame.origin.y > 0 {
      return
    }
    if frame.origin.y < WBRefreshControlOffset && !rotateFlag {
      rotateFlag = true
    } else if frame.origin.y >= WBRefreshControlOffset && rotateFlag {
      rotateFlag = false
    }
  }
  
  override init() {
    super.init()
    setupUI()
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
    // 使用KVO监听位置变化
    DispatchQueue.main.async {
      self.addObserver(self, forKeyPath: "frame", context: nil)
    }
  }
  
  deinit {
    self.removeObserver(self, forKeyPath: "frame")
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
