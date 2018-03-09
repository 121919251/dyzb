//
//  AppDelegate.swift
//  DYZB
//
//  Created by 郭洋 on 2018/1/27.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }

}

