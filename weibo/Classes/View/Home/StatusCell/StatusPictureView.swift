//
//  StatusPictureView.swift
//  weibo
//
//  Created by liyang on 2024/8/28.
//

import UIKit
import SDWebImage

private let StatusPictureViewItemMargin: CGFloat = 8
private let StatusPictureCellId = "StatusPictureCellId"

class StatusPictureView: UICollectionView {
  
  var viewModel: StatusViewModel? {
    didSet {
      sizeToFit()
      // 刷新数据 - 如果不刷新，后续的 collectionView 一旦被复用, 不再调用数据源方法
      reloadData()
    }
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return calcViewSize()
  }
  
  init() {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = StatusPictureViewItemMargin
    layout.minimumLineSpacing = StatusPictureViewItemMargin
    super.init(frame: CGRectZero, collectionViewLayout: layout)
    // 设置数据源
    dataSource = self
    // 注册可重用cell
    register(StatusPictureCell.self, forCellWithReuseIdentifier: StatusPictureCellId)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension StatusPictureView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.thumbnailUrls?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureCellId, for: indexPath) as! StatusPictureCell
    cell.backgroundColor = UIColor.red
    cell.imageUrl = viewModel!.thumbnailUrls![indexPath.item]
    return cell
  }
}


// MARK: - 计算视图大小
extension StatusPictureView {
  /// 计算视图大小
  private func calcViewSize() -> CGSize {
    // 1.
    // 每行的照片数量
    let rowCount: CGFloat = 3
    let maxWidth = UIScreen.main.bounds.width -  2 * StatusCellMargin
    let itemWidth = (maxWidth - 2 * StatusPictureViewItemMargin) / rowCount
    // 2. 设置 layout 的 itemSize
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    
    // 3. 获取图片数量
    let count = viewModel?.thumbnailUrls?.count ?? 0
    if count == 0 {
      return CGSizeZero
    }
    
    if count == 1 {
      // TODO
      let size = CGSize(width: 150, height: 120)
      layout.itemSize = size
      return size
    }
    
    // 四张图片 -> 2 * 2
    if count == 4 {
      let w = 2 * itemWidth + StatusPictureViewItemMargin
      return CGSize(width: w, height: w)
    }
    // 其他图片 3 * 3
    let row = CGFloat((count - 1) / Int(rowCount) + 1)
    let h = row * itemWidth + (row - 1) * StatusPictureViewItemMargin
    let w = rowCount * itemWidth + (rowCount - 1) * itemWidth
    return CGSize(width: w, height: h)
  }
}

// MARK: - 微博配图cell
private class StatusPictureCell: UICollectionViewCell {
  
  var imageUrl: URL? {
    didSet {
      iconView.sd_setImage(
        with: imageUrl,
        placeholderImage: nil,
        options: [SDWebImageOptions.retryFailed, SDWebImageOptions.refreshCached]
      )
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    contentView.addSubview(iconView)
    // 设置布局
    iconView.snp_makeConstraints { make in
      make.edges.equalTo(contentView.snp_edges)
    }
  }
  
  private lazy var iconView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
}
