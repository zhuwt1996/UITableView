//
//  RefreshViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/27.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    //添加数据源
    var dataSource = [["微信":"yes"],["QQ":"no"],["ApplePay":"no"],["支付宝":"no"],["银联":"no"]]
    let header = MJRefreshNormalHeader()
    var tableView : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        
        tableView?.delegate = self
        tableView!.dataSource = self
        
        //隐藏最后更新时间
        header.lastUpdatedTimeLabel.isHidden = false
        //隐藏刷新状态
        header.stateLabel.isHidden = false
        //MJRefreshState：
        //pulling：下拉中
        header.setTitle("下拉中", for: MJRefreshState.pulling)
        //refreshing：刷新中
        header.setTitle("刷新中", for: MJRefreshState.refreshing)
        //idle：刷新完毕
        header.setTitle("刷新完毕", for: MJRefreshState.idle)
        
        //隐藏⬆️箭头
        header.arrowView.isHidden = false
        //刷新样式,设置为white时无法显示⭕️
        header.activityIndicatorViewStyle = .gray
        //绑定事件（如重新加载数据）
        header.setRefreshingTarget(self, refreshingAction: #selector(reRoadNewData))
        
        tableView!.mj_header = header
        
        let rightBarButton = UIBarButtonItem(title: "DIYrefresh", style: .plain, target: self, action: #selector(nextButtonClick))
        navigationItem.rightBarButtonItems = [rightBarButton]
    }
    
    @objc func nextButtonClick() {
        let refresh = DIYRefreshViewController()
        refresh.title = "自定义gif刷新"
        navigationController?.pushViewController(refresh, animated: false)
    }
    
    // 2.实现下拉刷新和上拉加载的事件。
    // 头部的下拉刷新触发事件
    @objc fileprivate func reRoadNewData () {
        // 可在此处实现下拉刷新时要执行的代码
        // 模拟延迟3秒
        tableView?.reloadData()
        Thread.sleep(forTimeInterval: 2)
        // 结束刷新
        tableView!.mj_header.endRefreshing()
    }
    
}

extension RefreshViewController{
    //某一章节cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    //设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "connectCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        let dict = dataSource[indexPath.row]
        cell?.textLabel?.text = dict.keys.first
        return cell!
    }
}

extension RefreshViewController{
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    // 设置 section 的 header 高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    // 设置 section 的 footer 高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    //设置footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
}
