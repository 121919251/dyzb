//
//  HomeViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/1/30.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    //懒加载属性
    private var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    private var pageContentView: PageContentView = {
        let topH = kStatusBarH + kNavigationH + kTitleViewH
        let contentFrame = CGRect(x: 0, y: topH, width: kScreenW, height: kScreenH - topH)
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension HomeViewController {
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏
        setupNavigationBar()
        //2.添加TitleView
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar() {
        //设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName : "logo")
        //设置右侧的item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highLight: "Image_my_history_click", size: size)
        let seardchItem = UIBarButtonItem(imageName: "btn_search", highLight: "btn_search_clicked", size: size)
        let qrcpdeItem = UIBarButtonItem(imageName: "Image_scan", highLight: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, seardchItem, qrcpdeItem]
    }
}

