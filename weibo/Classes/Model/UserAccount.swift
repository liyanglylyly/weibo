//
//  UsweAccount.swift
//  weibo
//
//  Created by liyang on 2024/8/21.
//

import UIKit

class UserAccount: NSObject {
  
  @objc var access_token: String = ""
  @objc var expires_in: TimeInterval = 0
  @objc var uid: TimeInterval = 0
  @objc var remind_in: TimeInterval = 0
  @objc var isRealName: Bool = false
  
  init(dict: [String: Any]) {
    super.init()
//    dictionaryWithValues(forKeys: dict)
    setValuesForKeys(dict)
  }
  
  override class func setValue(_ value: Any?, forUndefinedKey key: String) {
    
  }
  
  override var description: String {
    let keys = ["access_token", "expires_in", "uid", "remind_in", "isRealName"]
    return dictionaryWithValues(forKeys: keys).description
  }

}
