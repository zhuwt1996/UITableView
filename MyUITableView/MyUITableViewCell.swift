//
//  MyUITableViewCell.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/26.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MyUITableViewCell: UITableViewCell {
    //定义每个cell的宽度
    let width = UIScreen.main.bounds.width
    var userLabel:UILabel!      // 名字
    var sexLabel:UILabel!       // 性别
    var iconImv:UIImageView!    // 头像
    
    //重写init方法，设置UI
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    private func setupUI(){
        
        userLabel = UILabel(frame: CGRect(x: 74, y: 18, width: 100, height: 15))
        userLabel.textColor = UIColor.black
        userLabel.font = UIFont.boldSystemFont(ofSize: 15)
        userLabel.textAlignment = .left
        
        
        sexLabel = UILabel(frame: CGRect(x: 200, y: 20, width: 50, height: 13))
        sexLabel.textColor = UIColor.black
        sexLabel.font = UIFont.systemFont(ofSize: 13)
        sexLabel.textAlignment = .left
        
        iconImv = UIImageView(frame: CGRect(x: 20, y: 15, width: 44, height: 44))
        iconImv.layer.masksToBounds = true
        iconImv.layer.cornerRadius = 22.0
        
        self.contentView.addSubview(userLabel)
        self.contentView.addSubview(sexLabel)
        self.contentView.addSubview(iconImv)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
