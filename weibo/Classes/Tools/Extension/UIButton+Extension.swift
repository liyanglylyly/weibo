//
//  UIButton+Extension.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import Foundation
import UIKit

extension UIButton {
  // 便利构造函数
  convenience init(imageName: String, backImageName: String) {
    self.init()
    setImage(UIImage(named: imageName), for: .normal);
    setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted);
    setBackgroundImage(UIImage(named: backImageName), for: .normal);
    setBackgroundImage(UIImage(named: backImageName + "_highlighted"), for: .highlighted)
    sizeToFit()
  }
}
