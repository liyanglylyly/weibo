//
//  StatusViewModel.swift
//  weibo
//
//  Created by liyang on 2024/8/25.
//

import Foundation
import UIKit

// 微博视图模型, 处理单条微博的业务逻辑
class StatusViewModel: CustomStringConvertible {
  var status: Status
  
  // 用户头像url
  var userProfileUrl: URL {
    return URL(string: status.user?.profile_image_url ?? "")!
  }
  
  // 用户默认头像
  var userDefaultIconView: UIImage {
    return UIImage(named: "avatar_default_big")!
  }
  
  var userVipImage: UIImage {
    return UIImage(named: "avatar_vip")!
  }
  
  // 用户会员图标
  var userMemberImage: UIImage {
//    if status.user?.mbrank > 0 && status.user!.mbrank < 7 {
//      return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
//    }
    return UIImage(named: "common_icon_membership_level1")!
  }
  
  init(status: Status) {
    self.status = status
    print(status)
  }
  
  // 描述信息
  var description: String {
    return status.description
  }
}
