//
//  SelectViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/27.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

//选择、移动、增删
class SelectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    //添加数据源
    var dataSource = [["微信":"yes"],["QQ":"no"],["ApplePay":"no"],["支付宝":"no"],["银联":"no"]]
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let rightBar = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClick))
        navigationItem.rightBarButtonItem = rightBar
        
        let rightBarButton = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(nextButtonClick))
        navigationItem.rightBarButtonItems = [rightBarButton,rightBar]
    }
    
    @objc func addButtonClick() {
        //添加一种支付方式，开启或关闭编辑状态
        self.tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @objc func nextButtonClick() {
        let refresh = RefreshViewController()
        refresh.title = "上拉下拉刷新"
        navigationController?.pushViewController(refresh, animated: false)
    }
    
}

extension SelectViewController{
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
        if dict.values.first == "yes" {
            cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    //选中一个cell以后重置每个cell的状态
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            var i = 0
            //遍历datasource
            for var dict in dataSource{
                if i == indexPath.row{
                    //第i个被选中
                    dict[dict.keys.first!] = "yes"
                    dataSource[i] = dict
                }else{
                    dict[dict.keys.first!] = "no"
                    dataSource[i] = dict
                }
                i = i + 1
            }
        
            tableView.reloadData()
    }
    
    //开启编辑模式时触发
    //新增删除
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        if indexPath.row == 1 || indexPath.row == 3{
//            return .delete
//        }else{
//            return .insert
//        }
//    }
    //移动
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    //点击编辑按钮时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert{
            dataSource.insert(["Cash pay":"no"], at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .right)
        }else{
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
        
    }
    
    // 设置 cell 是否允许移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 移动 cell 时触发
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 需要维护datasource
        let data = dataSource[sourceIndexPath.row]
        dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(data, at: destinationIndexPath.row)
    }
    
}

extension SelectViewController{
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
