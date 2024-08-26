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
  private lazy var contentLabel: UILabel = UILabel(title: "微博正文", fontSize: 15)
  private lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
}


extension StatusCell {
  private func setupUI() {
    
  }
}
