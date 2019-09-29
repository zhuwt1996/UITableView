//
//  DIYRefreshViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/29.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class DIYRefreshViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataSource = [["微信":"yes"],["QQ":"no"],["ApplePay":"no"],["支付宝":"no"],["银联":"no"]]
    
    var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        
        tableView?.delegate = self
        tableView!.dataSource = self

        let header = DiyRefreshHeader()
//        //隐藏最后更新时间
        header.lastUpdatedTimeLabel.isHidden = true
//        //隐藏刷新状态
        header.stateLabel.isHidden = true
        tableView!.mj_header = header
    }
    
    @objc fileprivate func reRoadNewData () {
        // 可在此处实现下拉刷新时要执行的代码
        // 模拟延迟3秒
        tableView?.reloadData()
        Thread.sleep(forTimeInterval: 4)
        // 结束刷新
        tableView!.mj_header.endRefreshing()
    }
}

extension DIYRefreshViewController{
    //某一章节cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    //设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "diyCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        let dict = dataSource[indexPath.row]
        cell?.textLabel?.text = dict.keys.first
        return cell!
    }
    
    //设置footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
}
