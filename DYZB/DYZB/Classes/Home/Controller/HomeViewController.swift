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
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        let topH = kStatusBarH + kNavigationH + kTitleViewH
        let contentFrame = CGRect(x: 0, y: topH, width: kScreenW, height: kScreenH - topH - kTabBarH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunyViewController())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
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
        //3.添加contentViw
        view.addSubview(pageContentView)
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

//遵守PageTitleViewDelegate协议
extension HomeViewController : PageTileViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(index: index)
    }
}

//遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

