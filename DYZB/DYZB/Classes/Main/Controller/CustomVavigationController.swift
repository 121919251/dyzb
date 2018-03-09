//
//  CustomVavigationController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/8.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class CustomVavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.获取系统pop手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        //2.获取手势添加到的view中
        guard let gesView = systemGes.view else {return}
        //3.获取target/action
        //3.1使用运行时机制查看所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        //3.2取出target
        guard let target = targetObjc.value(forKey: "target") else {return}
        //3.3取出action
        //guard let action = targetObjc.value(forKey: "action") as? Selector else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏要push控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
