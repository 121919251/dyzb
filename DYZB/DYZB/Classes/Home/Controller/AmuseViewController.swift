//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/3.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    //懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
    override func loadData() {
        //1.给父类中的ViewModel赋值
        baseVM = amuseVM
        //2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            self.loadDataFinished()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
}
