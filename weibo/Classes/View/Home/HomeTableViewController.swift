//
//  HomeTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit
import SVProgressHUD

private let StatusCellNormalCellId = "StatusCellNormalCellId"

class HomeTableViewController: VisitorTableViewController {
  
  private lazy var listViewModel = StatusListViewModel()
  
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
    listViewModel.loadStatus { isSuccess in
      if !isSuccess {
        SVProgressHUD.show(withStatus: "加载数据失败")
       return
      }
      print(self.listViewModel.statusList)
      self.tableView.reloadData()
    }
  }
}

// MARK: - 数据源方法
extension HomeTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listViewModel.statusList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalCellId, for: indexPath)
    cell.textLabel?.text = listViewModel.statusList[indexPath.row].user?.screen_name
    return cell
  }
}
