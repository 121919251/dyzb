//
//  FunyViewModel.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/8.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class FunyViewModel : BaseViewModel {

}

extension FunyViewModel {
    func loadFunyData(finishCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, UrlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/1", parameters: ["limit" : 30, "offset" : 0], finishCallback: finishCallback)
    }
}
