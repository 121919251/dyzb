//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/1.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

@objcMembers
class BaseGameModel: NSObject {
    //定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //自定义构造函数
    override init() {
        
    }
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
