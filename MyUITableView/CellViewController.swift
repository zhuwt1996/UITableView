//
//  CellViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/26.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class CellViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //定义数据源,字典型数组
    var dataSource = [[String:String]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let  tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dataSource = [["name":"朱武涛","sex":"male","icon":"zhuwutao"],
                      ["name":"❤️","sex":"female","icon":"zxx"],
                      ["name":"公众号","sex":"random","icon":"gzh"],
                      ["name":"文件传输助手","sex":"random","icon":"wjcszs"]]
        tableView.reloadData()
        
        
        let rightBarButton = UIBarButtonItem(title: "索引", style: .plain, target: self, action: #selector(nextButtonClick))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func nextButtonClick() {
        let connect = ConnectViewController()
        connect.title = "通讯录"
        navigationController?.pushViewController(connect, animated: false)
    }
    
}

extension CellViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "defineCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? MyUITableViewCell
        if cell == nil {
            cell = MyUITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        //cell与datasource交互，cell定义了样式，从datasource中拿数据
        let dict = dataSource[indexPath.row]
        cell?.iconImv.image = UIImage(named: dict["icon"]!)
        cell?.userLabel.text = dict["name"]
        cell?.sexLabel.text = dict["sex"]
        
        return cell!
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //设置footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
}
