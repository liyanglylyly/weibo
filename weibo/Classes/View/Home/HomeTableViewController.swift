//
//  HomeTableViewController.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit
import SVProgressHUD

/// 原创微博
let StatusCellNormalCellId = "StatusCellNormalCellId"
/// 转发微博
let StatusCellRetweetedCellId = "StatusCellRetweetedCellId"

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
    tableView.register(StatusNormalCell.self, forCellReuseIdentifier: StatusCellNormalCellId)
    tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedCellId)
    tableView.separatorStyle = .none
    // 自动计算行高 - 需要一个自上而下的自动布局的控件，指定一个向下的约束
    tableView.estimatedRowHeight = 400
//    tableView.rowHeight = UITableView.automaticDimension
    // 下拉刷新
    refreshControl = UIRefreshControl()
    // 添加监听方法
    refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    let v = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
    v.backgroundColor = UIColor.red
    refreshControl?.addSubview(v)
    refreshControl?.tintColor = UIColor.clear
  }
  
  // 加载数据
  @objc private func loadData() {
    listViewModel.loadStatus { isSuccess in
      // 关闭刷新控件
      self.refreshControl?.endRefreshing()
      if !isSuccess {
        SVProgressHUD.show(withStatus: "加载数据失败")
       return
      }
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
    let vm = listViewModel.statusList[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellId, for: indexPath) as! StatusCell
//    cell.textLabel?.text = listViewModel.statusList[indexPath.row].status.user?.screen_name
    cell.viewModel = vm
    return cell
  }
  
  // 实际开发中行高要缓存 - 放在视图模型中
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let vm = listViewModel.statusList[indexPath.item]
    return vm.rowHeight
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
