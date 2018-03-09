//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/2.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchorModels.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播模型的对象数组
    lazy var anchorModels : [AnchorModel] = [AnchorModel]()
}
