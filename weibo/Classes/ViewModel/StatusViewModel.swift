//
//  StatusViewModel.swift
//  weibo
//
//  Created by liyang on 2024/8/25.
//

import Foundation

// 微博视图模型, 处理单条微博的业务逻辑
class StatusViewModel {
  var status: Status
  
  init(status: Status) {
    self.status = status
  }
}
