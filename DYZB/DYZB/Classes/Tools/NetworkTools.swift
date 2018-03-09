//
//  NetworkTools.swift
//  Alamofire测试
//
//  Created by 郭洋 on 2018/2/2.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(URLString : String, type : MethodType, parameters : [String : Any]? = nil, headers : [String : String]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
        
            // 3.获取结果
            guard let result = response.result.value else {return}
        
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
