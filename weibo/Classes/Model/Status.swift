//
//  Status.swift
//  weibo
//
//  Created by liyang on 2024/8/25.
//

import UIKit
// 微博数据模型
class Status: NSObject {
  @objc var id: Int = 0
  @objc var text: String?
  @objc var created_at: String?
  @objc var source: String?
  @objc var user: User?
  @objc var pic_urls: [[String: String]]?
  // 转发的微博
  @objc var retweeted_status: Status?
  
  init(dict: [String: Any]) {
    super.init()
    // 如果使用KVC时, 如果value是个字典, 会直接给属性转换成字典
    setValuesForKeys(dict)
  }
  

  override func setValue(_ value: Any?, forKey key: String) {
    if key == "user" {
      if let dict = value as? [String: Any] {
        user = User(dict: dict)
      }
      return
    }
    if key == "retweeted_status" {
      if let dict = value as? [String: Any] {
        retweeted_status = Status(dict: dict)
      }
      return
    }
    super.setValue(value, forKey: key)
  }

  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {
  }

  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
  
  override var description: String {
    let keys = ["id", "text", "created_at", "source", "user", "pic_urls", "retweeted_status"]
    return dictionaryWithValues(forKeys: keys).description
  }
}
