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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // 注册可重用cell
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NewFeatureViewCellId)

  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }


  // 每个分组中格子的数量
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return NewFeatureImageCount
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFeatureViewCellId, for: indexPath)
    cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.yellow
        
    return cell
  }
}
