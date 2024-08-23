//
//  UserAccountViewModel.swift
//  weibo
//
//  Created by liyang on 2024/8/23.
//

import Foundation

// 模型通常继承 NSObject -> 可以使用 KVC 设置属性, 简化对象构造
// 视图模型作用: 封装业务逻辑, 通常没有复杂的属性
class UserAccountViewModel {
  var account: UserAccount?
  
  private var accountPath: String {
    return NSHomeDirectory() + "/Documents/archive.plist"
  }
  
  init() {
    do {
      // 从磁盘读取归档数据
      let data = try Data(contentsOf: URL(fileURLWithPath: accountPath))
      account = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserAccount
    } catch {
      print("Unarchiving failed: \(error)")
    }

  }
}
