//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/3.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, UrlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishCallback: finishCallback)
    }
}
