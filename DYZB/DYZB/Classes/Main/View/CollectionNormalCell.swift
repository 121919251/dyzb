//
//  CollectionNormalCellCollectionViewCell.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/1.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    //定义控件
    @IBOutlet weak var roomnameLabel: UILabel!
    //定义属性
    override var anchor : AnchorModel? {
        didSet {
            //将属性传给父类
            super.anchor = anchor
            //显示房间名称
            roomnameLabel.text = anchor?.room_name
        }
    }
}
