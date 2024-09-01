//
//  StatusNormalCell.swift
//  weibo
//
//  Created by liyang on 2024/9/1.
//

import UIKit

class StatusNormalCell: StatusCell {
  
  override var viewModel: StatusViewModel? {
    didSet {
      
      pictureView.snp_updateConstraints { make in
        let offset = viewModel?.thumbnailUrls?.count ?? 0 > 0 ? StatusCellMargin : 0
        make.top.equalTo(contentLabel.snp_bottom).offset(offset)
      }
    }
  }
  
  override func setupUI() {
    super.setupUI()
    pictureView.snp_makeConstraints { make in
      make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
      make.left.equalTo(contentLabel.snp_left)
      make.width.equalTo(contentView.snp_width).offset(-2 * StatusCellMargin)
      make.height.equalTo(90)
    }
  }

}
