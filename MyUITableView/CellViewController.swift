//
//  CellViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/26.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class CellViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    //定义数据源,字典型数组
    var dataSource = [[String:String]()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let  tableView = UITableView(frame: view.bounds, style: .plain)
        
        
        
        
        dataSource = [["name":"朱武涛","sex":"male","icon":"zhuwutao"],
                      ["name":"❤️","sex":"female","icon":"zxx"],
                      ["name":"公众号","sex":"random","icon":"gzh"],
                      ["name":"文件传输助手","sex":"random","icon":"wjcszs"]]
    }
}
