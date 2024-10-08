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
  
  convenience init(title: String, color: UIColor, backImageName: String) {
    self.init()
    setTitle(title, for: .normal)
    setTitleColor(color, for: .normal)
    sizeToFit()
    setBackgroundImage(UIImage(named: backImageName), for: .normal)
  }
  
  convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String) {
    self.init()
    setTitle(title, for: .normal)
    setTitleColor(color, for: .normal)
    setImage(UIImage(named: imageName), for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    sizeToFit()
  }
}
