//
//  StatusCellTopView.swift
//  weibo
//
//  Created by liyang on 2024/8/26.
//

import UIKit

let StatusCellMargin: CGFloat = 12
let StatusCellIconWidth: CGFloat = 35

class StatusCellTopView: UIView {
  
  var viewModel: StatusViewModel? {
    didSet {
      nameLabel.text = viewModel?.status.user?.screen_name
      iconView.sd_setImage(with: viewModel?.userProfileUrl, placeholderImage: viewModel?.userDefaultIconView)
      memberIconView.image = viewModel?.userMemberImage
      vipIconView.image = viewModel?.userVipImage
      timeLabel.text = "刚刚"
      sourceLabel.text = "来自黑马"
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - 懒加载控件
  private lazy var iconView: UIImageView = UIImageView(imageName: "avatar_default_big")
  private lazy var nameLabel: UILabel = UILabel(title: "王老吴", fontSize: 14)
  private lazy var memberIconView: UIImageView = UIImageView(imageName: "common_icon_membership_level1")
  private lazy var vipIconView: UIImageView = UIImageView(imageName: "avatar_vip")
  private lazy var timeLabel: UILabel = UILabel(title: "现在", fontSize: 11, color: UIColor.orange)
  private lazy var sourceLabel: UILabel = UILabel(title: "来源", fontSize: 11, color: UIColor.orange)

}

extension StatusCellTopView {
  private func setupUI() {
    backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    // 1. 添加控件
    addSubview(iconView)
    addSubview(nameLabel)
    addSubview(memberIconView)
    addSubview(vipIconView)
    addSubview(timeLabel)
    addSubview(sourceLabel)
    // 2. 自动布局
    iconView.snp_makeConstraints { make in
      make.top.equalTo(self.snp_top).offset(StatusCellMargin)
      make.left.equalTo(self.snp_left).offset(StatusCellMargin)
      make.width.equalTo(StatusCellIconWidth)
      make.height.equalTo(StatusCellIconWidth)
    }
    nameLabel.snp_makeConstraints { make in
      make.top.equalTo(iconView.snp_top)
      make.left.equalTo(iconView.snp_right).offset(StatusCellMargin)
    }
    memberIconView.snp_makeConstraints { make in
      make.top.equalTo(nameLabel.snp_top)
      make.left.equalTo(nameLabel.snp_right).offset(StatusCellMargin)
    }
    vipIconView.snp_makeConstraints { make in
      make.centerX.equalTo(iconView.snp_right)
      make.centerY.equalTo(iconView.snp_bottom)
    }
    timeLabel.snp_makeConstraints { make in
      make.bottom.equalTo(iconView.snp_bottom)
      make.left.equalTo(iconView.snp_right).offset(StatusCellMargin)
    }
    sourceLabel.snp_makeConstraints { make in
      make.bottom.equalTo(timeLabel.snp_bottom)
      make.left.equalTo(timeLabel.snp_right).offset(StatusCellMargin)
    }
  }
}
