//
//  MainViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/1/29.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyBorad: "Home")
        addChildVc(storyBorad: "Live")
        addChildVc(storyBorad: "Follow")
        addChildVc(storyBorad: "Profile")
    }
    
    private func addChildVc(storyBorad : String) {
        //1.通过storyboard获取控制器
        let vc = UIStoryboard(name : storyBorad, bundle : nil).instantiateInitialViewController()!
        //2.将childVc作为子控制器
        addChildViewController(vc)
    }

}
