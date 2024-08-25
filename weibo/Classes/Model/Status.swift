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
  
  init(dict: [String: Any]) {
    super.init()
    setValuesForKeys(dict)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {
    print("forUndefinedKey: \(key)")
  }

  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
  
  override var description: String {
    let keys = ["id", "text", "created_at", "source"]
    return dictionaryWithValues(forKeys: keys).description
  }
}
