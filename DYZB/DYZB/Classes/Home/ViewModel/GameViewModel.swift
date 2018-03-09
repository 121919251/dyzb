//
//  GameViewModel.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/1.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", type: .get, parameters: ["shortName" : ""]) { (result) in
            //1.获取数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}

            //2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }

            //3.完成回调
            finishedCallback()
        }
    }
}

