//
//  UsweAccount.swift
//  weibo
//
//  Created by liyang on 2024/8/21.
//

import UIKit

class UserAccount: NSObject {
  
  @objc var access_token: String?
  // 一旦从服务器获得过期时间, 立刻计算准确的日期
  @objc var expires_in: TimeInterval = 0 {
    didSet {
      // 计算过期时间
      expireDate = NSDate(timeIntervalSinceNow: expires_in)
    }
  }
  
  // 过期日期
  var expireDate: NSDate?
  
  @objc var uid: TimeInterval = 0
  
  init(dict: [String: Any]) {
    super.init()
//    dictionaryWithValues(forKeys: dict)
    setValuesForKeys(dict)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {
    print("forUndefinedKey: \(key)")
  }

  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
  

  
  override var description: String {
    let keys = ["access_token", "expires_in", "uid", "expireDate"]
    return dictionaryWithValues(forKeys: keys).description
  }

}
