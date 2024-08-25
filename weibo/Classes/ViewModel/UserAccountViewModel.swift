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
  // 单例 - 解决避免重复从沙盒加载 归档 文件
  static let sharedUserAccount = UserAccountViewModel()
  
  var account: UserAccount?
  
  var accessToken: String? {
    if !isExpired {
      return account?.access_token
    }
    return nil
  }
  
  // 用户头像URL
  var avatarUrl: NSURL {
    return NSURL(string: (account?.avatar_large) ?? "")!
  }
  
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
  
  // 构造函数 - 私有化, 会要求外部只能通过单例访问
  private init() {
    do {
      // 从磁盘读取归档数据
      let data = try Data(contentsOf: URL(fileURLWithPath: accountPath))
      account = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserAccount
      // 判断token是否过期
      if isExpired {
        print("账户已经过期")
        account = nil
      }
    } catch {
      print("Unarchiving failed: \(error)")
    }

  }
}


extension UserAccountViewModel {
  func loadAccessToken(code: String, finished: @escaping (_ isSuccessed: Bool) -> ()) {
    NetworkTools.sharedTools.loadAccessToken(code: code) { (result, error) in
      if error != nil {
        finished(false)
        return
      }
      self.account = UserAccount(dict: result as! [String: Any])
      self.loadUserInfo(account: self.account!, finished: finished)
    }
  }
  
  func loadUserInfo(account: UserAccount, finished: @escaping (_ isSuccessed: Bool) -> ()) {
    NetworkTools.sharedTools.loadUserInfo(uid: account.uid) { result, error in
      if error != nil {
        print("加载用户失败")
        finished(false)
        return
      }
      // result 一定有内容
      // 一定是字典
      guard let dict = result as? [String: Any] else {
        print("格式错误")
        finished(false)
        return
      }
      account.screen_name = dict["screen_name"] as? String
      account.avatar_large = dict["avatar_large"] as? String
      account.saveUserAccount(accountPath: self.accountPath)
      //
      finished(true)
    }
  }
}
