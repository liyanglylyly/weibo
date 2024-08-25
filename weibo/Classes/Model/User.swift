//
//  User.swift
//  weibo
//
//  Created by liyang on 2024/8/25.
//

import UIKit

class User: NSObject {

  @objc var id: Int = 0
  @objc var screen_name: String?
  @objc var profile_image_url: String?
  @objc var verified_type: Int = 0
  @objc var mbrank: Int = 0
  
  init(dict: [String: Any]) {
    super.init()
    setValuesForKeys(dict)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {
  }

  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
  
  override var description: String {
    let keys = ["id", "screen_name", "profile_image_url", "verified_type", "mbrank"]
    return dictionaryWithValues(forKeys: keys).description
  }
}
