//
//  UIImageView+Extension.swift
//  weibo
//
//  Created by liyang on 2024/8/17.
//

import UIKit

extension UIImageView {
  convenience init(imageName: String) {
    self.init(image: UIImage(named: imageName))
  }
}
