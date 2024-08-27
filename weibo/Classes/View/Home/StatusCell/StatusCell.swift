//
//  StatusCell.swift
//  weibo
//
//  Created by liyang on 2024/8/26.
//

import UIKit

class StatusCell: UITableViewCell {
  
  // 微博视图模型
  var viewModel: StatusViewModel? {
    didSet {
      topView.viewModel = viewModel
      contentLabel.text = viewModel?.status.text
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
 // MARK: - 懒加载控件
  private lazy var topView: StatusCellTopView = StatusCellTopView()
  private lazy var contentLabel: UILabel = UILabel(title: "微博正文", fontSize: 15, screenInset: StatusCellMargin)
  private lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
}


extension StatusCell {
  private func setupUI() {
    // 1. 添加控件
    contentView.addSubview(topView)
    contentView.addSubview(contentLabel)
    // 2. 自动布局
    topView.snp_makeConstraints { make in
      make.top.equalTo(contentView.snp_top)
      make.left.equalTo(contentView.snp_left)
      make.right.equalTo(contentView.snp_right)
      make.height.equalTo(StatusCellMargin + StatusCellIconWidth)
    }
    contentLabel.snp_makeConstraints { make in
      make.top.equalTo(topView.snp_bottom).offset(StatusCellMargin)
      make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)
      // 指定向下的约束
      make.bottom.equalTo(contentView.snp_bottom).offset(-StatusCellMargin)
    }
  }
}
