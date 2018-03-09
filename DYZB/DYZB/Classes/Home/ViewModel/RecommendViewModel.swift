//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/2.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    //懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> ()) {
        //定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : "(\(NSDate().timeIntervalSince1970)"]
        //创建group
        let dGroup = DispatchGroup()
        //1.请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getBigDataRoom", type: .get
        , parameters: ["time" : "(\(NSDate().timeIntervalSince1970)"]) { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String : Any] else {return}
            //2.根据key获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            //3.遍历数组，转换成模型对象
            self.bigDataGroup.tag_name = "推荐"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                self.bigDataGroup.anchorModels.append(AnchorModel(dict: dict))
            }
            dGroup.leave()
        }
        
        //2.请求颜值数据
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String : Any] else {return}
            //2.根据key获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            //3.遍历数组，转换成模型对象
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                self.prettyGroup.anchorModels.append(AnchorModel(dict: dict))
            }
            dGroup.leave()
        }
        
        //3.请求2-12部分的游戏数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getHotCate
        loadAnchorData(isGroupData: true, UrlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        //所有的数据都请求到，之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    //请求无限轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/slide/6", type: .get, parameters: ["version" : "2.3000"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
