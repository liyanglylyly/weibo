//
//  UILabel+Extension.swift
//  weibo
//
//  Created by liyang on 2024/8/17.
//


import UIKit

extension UILabel {
  convenience init(
    title: String = "",
    fontSize: CGFloat = 14,
    color: UIColor = UIColor.darkGray,
    screenInset: CGFloat = 0
  ) {
    self.init()
    text = title
    textColor = color
    font = UIFont.systemFont(ofSize: fontSize)
    numberOfLines = 0
    if screenInset == 0 {
      textAlignment = .center
    } else {
      preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
      textAlignment = .left
    }
  }
}
