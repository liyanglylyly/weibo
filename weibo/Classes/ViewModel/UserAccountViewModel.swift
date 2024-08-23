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
  
  // 判断账户是否过期
  private var isExpired: Bool {
//    return account?.expire_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending
    return false
  }
  
  // 用户是否登录
  var userLogin: Bool {
    return account?.access_token != nil && !isExpired
  }
  init() {
    do {
      // 从磁盘读取归档数据
      let data = try Data(contentsOf: URL(fileURLWithPath: accountPath))
      account = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserAccount
      // 判断token是否过期
      if isExpired {
        print("账户已经过期")
        account = nil
        return
      }
      print(account)
    } catch {
      print("Unarchiving failed: \(error)")
    }

  }
}
