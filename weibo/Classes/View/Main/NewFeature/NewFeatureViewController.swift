//
//  NewFeatureViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/24.
//

import UIKit

private let NewFeatureViewCellId = "NewFeatureViewCellId"
private let NewFeatureImageCount = 4
class NewFeatureViewController: UICollectionViewController {
  
  // 懒加载属性, 必须要在控制器实例化之后才会被创建
  
  init() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = UIScreen.main.bounds.size
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
    collectionView?.isPagingEnabled = true
    collectionView.bounces = false
    collectionView.showsHorizontalScrollIndicator = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // 注册可重用cell
    self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: NewFeatureViewCellId)

  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }


  // 每个分组中格子的数量
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return NewFeatureImageCount
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFeatureViewCellId, for: indexPath) as! NewFeatureCell
    cell.imageIndex = indexPath.item
    return cell
  }
  
  // ScrollView 停止滚动
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    // 在最后一夜才调用动画方法
    let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    if page != NewFeatureImageCount - 1 {
      return
    }
    let cell = collectionView.cellForItem(at: NSIndexPath(item: page, section: 0) as IndexPath) as! NewFeatureCell
    cell.showButtonAnim()
  }
}

// MARK: - 新特性 Cell
private class NewFeatureCell: UICollectionViewCell {
  
  /// 图像属性
  var imageIndex: Int = 0 {
    didSet {
      iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
      startButton.isHidden = true
    }
  }
  
  /// 点击
  @objc private func clickStartButton() {
    NotificationCenter.default.post(name: NSNotification.Name(WBSwitchRootViewControllerNotifition), object: nil)
  }
  
  /// 显示按钮动画
  func showButtonAnim() {
    startButton.isHidden = false
    startButton.transform = CGAffineTransformMakeScale(0, 0)
    startButton.isUserInteractionEnabled = false
    UIView.animate(withDuration: 1.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: []) {
      self.startButton.transform = CGAffineTransformIdentity
    } completion: { _ in
      self.startButton.isUserInteractionEnabled = true
    }

  }
  
  // frame 的大小是由layout.itemSize 指定的
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    addSubview(iconView)
    addSubview(startButton)
    iconView.frame = bounds
    startButton.snp_makeConstraints { make in
      make.centerX.equalTo(self.snp_centerX)
      make.bottom.equalTo(self.snp_bottom).multipliedBy(0.7)
    }
    startButton.addTarget(self, action: #selector(clickStartButton), for: .touchUpInside)

  }
  
  // MARK: - 懒加载控件
  private lazy var iconView: UIImageView = UIImageView()
  private lazy var startButton: UIButton = UIButton(title: "开始体验", color: UIColor.white, backImageName: "new_feature_finish_button")
}
