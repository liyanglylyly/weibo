//
//  HomeTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit

private let StatusCellNormalCellId = "StatusCellNormalCellId"

class HomeTableViewController: VisitorTableViewController {
  
  var dataList: [Status]?

  override func viewDidLoad() {
    super.viewDidLoad()
    if !UserAccountViewModel.sharedUserAccount.userLogin {
      visitorView?.setupInfo(imageName: nil, title: "关注一些人, 回这里看看有什么惊喜")
      return
    }
    prepareTableView()
    loadData()
  }
  
  private func prepareTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: StatusCellNormalCellId)
  }
  
  // 加载数据
  private func loadData() {
    NetworkTools.sharedTools.loadStatus { (result, error) -> () in
      if error != nil {
        print("出错了")
        return
      }
      let r = result as! [String: Any]
      guard let array = r["statuses"] as? [[String: Any]] else {
        print("数据格式有错误")
        return
      }
      // 1. 可变的数组
      var dataList = [Status]()
      // 2. 遍历数组
      for dict in array {
        dataList.append(Status(dict: dict))
      }
      self.dataList = dataList
      // 3. 刷新数据
      self.tableView.reloadData()
    }
  }
}

// MARK: - 数据源方法
extension HomeTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataList?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalCellId, for: indexPath)
    cell.textLabel?.text = dataList![indexPath.row].text
    return cell
  }
}
