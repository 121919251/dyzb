//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/3.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, UrlString : String, parameters : [String : Any]? = nil, finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(URLString: UrlString, type: .get, parameters: parameters) { (result) in
            //1.对结果进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}

            //2.遍历数组中的字典
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchorModels.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }

            //3.完成回调
            finishCallback()
        }
    }
}
