//
//  NewFeatureViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
  
  // 懒加载属性, 必须要在控制器实例化之后才会被创建
  
  init() {
    let layout = UICollectionViewFlowLayout()
    super.init(collectionViewLayout: layout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 0
  }


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
    return cell
  }
}
