//
//  DiyRefreshHeader.swift
//  MyUITableView
//
//  Created by ZWT on 2019/9/29.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class DiyRefreshHeader: MJRefreshGifHeader {

    var header = MJRefreshGifHeader()
    
    override func prepare() {
        super.prepare()
        // 设置普通状态的动画图片
        var pullingImages: Array<UIImage> = []
        for i in 1...9 {
            let image = UIImage(named: "loading_0\(i)")
            pullingImages.append(image!)
        }
        pullingImages.append(UIImage(named: "loading_10")!)
        
        header.setImages(pullingImages, for: .refreshing)
    
    }
}
