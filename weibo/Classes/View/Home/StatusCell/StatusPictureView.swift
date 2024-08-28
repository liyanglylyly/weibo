//
//  StatusPictureView.swift
//  weibo
//
//  Created by liyang on 2024/8/28.
//

import UIKit

class StatusPictureView: UICollectionView {
  init() {
    let layout = UICollectionViewFlowLayout()
    super.init(frame: CGRectZero, collectionViewLayout: layout)
    backgroundColor = UIColor.red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
