//
//  ViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/26.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UITableView--初始化"
        //初始化
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        //设置代理：UITableViewDelegate，UITableViewDataSource
        tableView.delegate = self
        //设置数据源
        tableView.dataSource = self
        
        let rightBarButton = UIBarButtonItem(title: "自定义", style: .plain, target: self, action: #selector(nextButtonClick))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func nextButtonClick() {
//        let next = NextViewController()
//        next.title = "自定义"
//        navigationController?.pushViewController(next, animated: true)
    }
    
    //每个section中cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    // 设置每个 Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 从tableview的重用池里通过cellID取一个cell
        let cellID = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        //设置cell的样式
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        //cell的标题
        cell?.textLabel?.text = "MyTile"
        //副标题
        cell?.detailTextLabel?.text = "Subtitle/content"
        return cell!
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}
