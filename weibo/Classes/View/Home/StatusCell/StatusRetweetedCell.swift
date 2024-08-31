//
//  StatusRetweetedCell.swift
//  weibo
//
//  Created by liyang on 2024/8/31.
//

import UIKit

class StatusRetweetedCell: StatusCell {
  // MARK: - 懒加载控件
  private lazy var backButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
    return button
  }()
  private lazy var retweetedLabel: UILabel = UILabel(title: "转发微博", fontSize: 14, color: UIColor.darkGray, screenInset: StatusCellMargin)
}

// MARK: - 设置界面
extension StatusRetweetedCell {
  override func setupUI() {
    super.setupUI()
    
    contentView.insertSubview(backButton, belowSubview: pictureView)
    contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
    
    backButton.snp_makeConstraints { make in
      make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
      make.left.equalTo(contentView.snp_left)
      make.right.equalTo(contentView.snp_right)
      make.bottom.equalTo(bottomView.snp_top)
    }
    retweetedLabel.snp_makeConstraints { make in
      make.top.equalTo(backButton.snp_top).offset(StatusCellMargin)
      make.left.equalTo(backButton.snp_left).offset(StatusCellMargin)
    }
    
    pictureView.snp_makeConstraints { make in
      make.top.equalTo(retweetedLabel.snp_bottom).offset(StatusCellMargin)
      make.left.equalTo(retweetedLabel.snp_left)
      make.width.equalTo(300)
      make.height.equalTo(90)
    }
  }
}
