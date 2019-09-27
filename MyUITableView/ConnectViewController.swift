//
//  ConnectViewController.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/27.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

//实现通讯录显示效果
class ConnectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    //datasource
    let contents:Dictionary<String,[String]> =
        ["A":["安其拉"],
         "B":["不知火舞","白起","扁鹊"],
         "C":["程咬金","成吉思汗","蔡文姬","曹操"],
         "D":["妲己","狄仁杰","典韦","貂蝉","达摩","大乔","东皇太一"],
         "G":["高渐离","关羽","宫本武藏","干将莫邪","鬼谷子"],
         "H":["韩信","后羿","花木兰","黄忠"],
         "J":["荆轲","姜子牙"],
         "L":["老夫子","刘邦","刘婵","鲁班七号","兰陵王","露娜","廉颇","李元芳","刘备","李白","吕布"],
         "M":["墨子","芈月"],
         "N":["牛魔","娜可露露","哪吒","女娲"],
         "P":["庞统"],
         "S":["孙膑","孙尚香","孙悟空"],
         "W":["王昭君","武则天"],
         "X":["项羽","小乔"],
         "Y":["亚瑟","虞姬","嬴政"],
         "Z":["周瑜","庄周","甄姬","钟无艳","张飞","张良","钟馗","赵云","诸葛亮"]]
    
    //用于存储datasource的key
    var keys:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        keys = contents.keys.sorted()
        
        let  tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ConnectViewController{
    //章节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    //某一章节cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = contents[keys[section]]
        return (index?.count)!
    }
    //设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "connectCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        let index = contents[keys[indexPath.section]]
        cell?.textLabel?.text = index?[indexPath.row]
        return cell!
    }
    //通讯录的A-Z header设置
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    //设置侧边索引序列
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
}
