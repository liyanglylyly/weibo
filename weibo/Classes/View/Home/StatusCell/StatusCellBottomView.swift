//
//  StatusCellBottomView.swift
//  weibo
//
//  Created by liyang on 2024/8/26.
//

import UIKit

class StatusCellBottomView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // 转发
  private lazy var retweeteButton = UIButton(title: "转发", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_retweet")
  // 评论
  private lazy var commentButton = UIButton(title: "评论", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_comment")
  // 赞
  private lazy var likeButton = UIButton(title: "赞", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_unlike")

}


extension StatusCellBottomView {
  private func setupUI() {
    
    backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    
    addSubview(retweeteButton)
    addSubview(commentButton)
    addSubview(likeButton)
    
    //
    retweeteButton.snp_makeConstraints { make in
      make.top.equalTo(self.snp_top)
      make.left.equalTo(self.snp_left)
      make.bottom.equalTo(self.snp_bottom)
    }
    
    commentButton.snp_makeConstraints { make in
      make.top.equalTo(retweeteButton.snp_top)
      make.left.equalTo(retweeteButton.snp_right)
      make.width.equalTo(retweeteButton.snp_width)
      make.height.equalTo(retweeteButton.snp_height)
    }
    
    likeButton.snp_makeConstraints { make in
      make.top.equalTo(commentButton.snp_top)
      make.left.equalTo(commentButton.snp_right)
      make.width.equalTo(commentButton.snp_width)
      make.height.equalTo(commentButton.snp_height)
      make.right.equalTo(self.snp_right)
    }
    
    // 分隔视图
    let sep1 = sepView()
    let sep2 = sepView()
    addSubview(sep1)
    addSubview(sep2)
    //
    let w = 0.5
    let scale = 0.4
    sep1.snp_makeConstraints { make in
      make.left.equalTo(retweeteButton.snp_right)
      make.centerY.equalTo(retweeteButton.snp_centerY)
      make.width.equalTo(w)
      make.height.equalTo(retweeteButton.snp_height).multipliedBy(scale)
    }
    sep2.snp_makeConstraints { make in
      make.left.equalTo(commentButton.snp_right)
      make.centerY.equalTo(retweeteButton.snp_centerY)
      make.width.equalTo(w)
      make.height.equalTo(retweeteButton.snp_height).multipliedBy(scale)
    }
  }
  
  private func sepView() -> UIView {
    let v = UIView()
    v.backgroundColor = UIColor.darkGray
    return v
  }
}
