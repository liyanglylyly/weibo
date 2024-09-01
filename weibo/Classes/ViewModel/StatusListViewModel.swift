//
//  StatusViewModel.swift
//  weibo
//
//  Created by liyang on 2024/8/25.
//

import Foundation
import SDWebImage

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
      
      // 5. 缓存单张图片
      self.cacheSingleImage(dataList: self.statusList)
    }
  }
  
  /// 缓存单张图片
  private func cacheSingleImage(dataList: [StatusViewModel]) {
    // 1. 创建调度组
    let group = DispatchGroup()
    let queue = DispatchQueue(label: "cache_images")
    var dataLength = 0
    for vm in dataList {
      // 判断图片数量是否是单张图片
      if vm.thumbnailUrls?.count != 1 {
        continue
      }
      // 获取url
      let url = vm.thumbnailUrls![0]
      print("开始缓存 \(url)")
      // SDWebImage 下载图像
      group.enter()
      queue.async {
        SDWebImageManager.shared.loadImage(
          with: url,
          options: [SDWebImageOptions.refreshCached, SDWebImageOptions.retryFailed],
          context: nil,
          progress: nil
        ) { image, _, _, _, _, _ in
          // 单张图片下载完成, 计算长度
          if image != nil {
            dataLength += NSData(data: image!.pngData()!).length
          }
          //
          group.leave()
        }
      }
    }
    // 监听调度组完成
    group.notify(queue: queue) {
      print("缓存成功 \(dataLength / 1024) K")
    }
  }
}
