//
//  UsweAccount.swift
//  weibo
//
//  Created by liyang on 2024/8/21.
//

import UIKit

class UserAccount: NSObject {
  
  @objc var access_token: String?
  @objc var expires_in: NSNumber = 0
  @objc var uid: NSNumber = 0
  
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
    let keys = ["access_token", "expires_in", "uid", "remind_in", "isRealName"]
    return dictionaryWithValues(forKeys: keys).description
  }

}
