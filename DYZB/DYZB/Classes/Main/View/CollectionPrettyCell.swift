//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/1.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    //控件属性
    @IBOutlet weak var cityLabel: UIButton!
    //定义模型
    override var anchor : AnchorModel? {
        didSet {
            //将属性传递给父类
            super.anchor = anchor
            //显示城市
            cityLabel.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
