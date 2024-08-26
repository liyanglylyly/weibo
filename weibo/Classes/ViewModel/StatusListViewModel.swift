//
//  StatusViewModel.swift
//  weibo
//
//  Created by liyang on 2024/8/25.
//

import Foundation

class StatusListViewModel {
    
  lazy var statusList = [StatusViewModel]()
  
  func loadStatus(finished: @escaping (_ isSuccess: Bool) -> ()) {
    NetworkTools.sharedTools.loadStatus { (result, error) -> () in
      if error != nil {
        print("出错了")
        finished(false)
        return
      }
      let r = result as! [String: Any]
      guard let array = r["statuses"] as? [[String: Any]] else {
        print("数据格式有错误")
        finished(false)
        return
      }
      // 1. 可变的数组
      var dataList = [StatusViewModel]()
      // 2. 遍历数组
      for dict in array {
        dataList.append(StatusViewModel(status: Status(dict: dict)))
      }
      // 3. 拼接数据
      self.statusList = dataList + self.statusList
      // 4. 完成回调
      finished(true)
    }
  }
}
