//
//  UsweAccount.swift
//  weibo
//
//  Created by liyang on 2024/8/21.
//

import UIKit

class UserAccount: NSObject, NSCoding {

  
  @objc var access_token: String?
  // 一旦从服务器获得过期时间, 立刻计算准确的日期
  @objc var expires_in: TimeInterval = 0 {
    didSet {
      // 计算过期时间
      expire_date = NSDate(timeIntervalSinceNow: expires_in)
    }
  }
  
  // 过期日期
  var expire_date: NSDate?
  
  @objc var uid: TimeInterval = 0
  // 用户昵称
  var screen_name: String?
  // 用户头像地址（大图），180×180像素
  var avatar_large: String?
  
  init(dict: [String: Any]) {
    super.init()
//    dictionaryWithValues(forKeys: dict)
    print(dict)
    setValuesForKeys(dict)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {
    print("forUndefinedKey: \(key)")
  }

  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
  

  
  override var description: String {
    let keys = ["access_token", "expires_in", "uid", "expire_date", "screen_name", "avatar_large"]
    return dictionaryWithValues(forKeys: keys).description
  }
  
  // MARK: - 保存当前对象
  func saveUserAccount(accountPath: String) {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
      try data.write(to: URL(fileURLWithPath: accountPath))
    } catch {
      
    }
  }
  
  // MARK: - 归档和解档
  // 归档 - 把当前对象保存到磁盘，
  func encode(with coder: NSCoder) {
    coder.encode(access_token, forKey: "access_token")
    coder.encode(expire_date, forKey: "expire_date")
    coder.encodeConditionalObject(uid, forKey: "uid")
    coder.encode(screen_name, forKey: "screen_name")
    coder.encode(avatar_large, forKey: "avatar_large")
  }
  
  // 解档 - 从磁盘加载二进制文件，转换成对象
  required init?(coder: NSCoder) {
    access_token = coder.decodeObject(forKey: "access_token") as? String
    expire_date = coder.decodeObject(forKey: "expire_date") as? NSDate
    uid = coder.decodeObject(forKey: "uid") as? TimeInterval ?? 0
    screen_name = coder.decodeObject(forKey: "screen_name") as? String
    avatar_large = coder.decodeObject(forKey: "avatar_large") as? String
  }
}

// 在extension中只允许写便利构造函数，而不能写指定构造函数
extension UserAccount {
  
}
