//
//  Common.swift
//  weibo
//
//  Created by liyang on 2024/8/17.
//

// 目的: 提供全局共享属性或者方法
import UIKit

// MARK： - 全局通知定义
///  切换根视图控制器通知
let WBSwitchRootViewControllerNotifition = "WBSwitchRootViewControllerNotifition"

// 全局外观渲染颜色
let WBAppearanceTintColor = UIColor.orange


// MARK: - 全局函数
/// 延迟在主线程执行函数
func delay(delta: Double, callFunc: @escaping () -> ()) {
  DispatchQueue.main.asyncAfter(deadline: .now() + delta) {
    callFunc()
  }
}
