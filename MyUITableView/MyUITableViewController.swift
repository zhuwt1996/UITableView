//
//  ViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/26.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MyUITableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UITableView--初始化"
        //初始化
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        //显示侧边拖动栏
        tableView.showsVerticalScrollIndicator = false
        //cell中间的间隔线，默认.singleLine表示
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        //设置代理：UITableViewDelegate，UITableViewDataSource
        tableView.delegate = self
        //设置数据源
        tableView.dataSource = self
        
        let rightBarButton = UIBarButtonItem(title: "cell", style: .plain, target: self, action: #selector(nextButtonClick))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func nextButtonClick() {
        let cell = CellViewController()
        cell.title = "与UITableViewCell交互"
        navigationController?.pushViewController(cell, animated: false)
    }
    
    //每个section中cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    //当style为grouped时，需要实现numberOfSections的代理方法
    public func numberOfSections(in tableView: UITableView) -> Int {
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
        //选中cell时的样式
        // default:默认的，点击灰色
        cell?.selectionStyle = .default
        //cell的标题
        cell?.textLabel?.text = "MyTile"
        //副标题
        cell?.detailTextLabel?.text = "副标题"
        return cell!
    }


}
//---UI相关代理方法
extension MyUITableViewController{
    // 设置 section 的 header 文字
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header-\(section)"
    }
    // 设置 section 的 footer 文字
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "footer-\(section)"
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    // 设置 section 的 header 高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    // 设置 section 的 footer 高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    // cell 的文字缩进（向右）
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 10
    }
    // 自定义 section 的 header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.orange
        return headerView
    }
    // 自定义 section 的 header
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.blue
        return footerView
    }
}

//---点击事件代理方法
extension MyUITableViewController{
    //点击cell后调用此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath.row:\(indexPath.row)index.section:\(indexPath.section)")
    }
    //---设置左滑删除
    //是否可编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    // 设置默认的左滑按钮的title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "WTbtn"
    }
    // 点击左滑出现的按钮时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("点击左滑出现的按钮时触发")
        return
    }
    // 左滑结束时调用(只对默认的左滑按钮有效，自定义按钮时这个方法无效)
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("滑动结束啦")
    }
    //自定义左滑按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cellActionA = UITableViewRowAction(style: .default, title: "按钮-1", handler: {_,_ in
            print("点击了 按钮-1")
        })
        cellActionA.backgroundColor = UIColor.green
        
        let cellActionB = UITableViewRowAction(style: .default, title: "按钮-2", handler: {_,_ in
            print("点击了 按钮-2")
        })
        return [cellActionA, cellActionB]
    }
}


