//
//  PageContentView.swift
//  DYZB
//
//  Created by 郭洋 on 2018/1/30.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellId = "ContentCellId"

class PageContentView: UIView {
    //定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isFobidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //懒加载属性
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        
        return collectionView
    }()
    //自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//设置界面
extension PageContentView {
    private func setupUI() {
        //1.将所有的子控制器添加到父控制器中
        for vc in childVcs {
            parentViewController?.addChildViewController(vc)
        }
        //2.添加UICollecionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFobidScrollDelegate = false
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        //2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//遵守UICollectionViewDelegate代理
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isFobidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isFobidScrollDelegate {return}
        //1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //4.如果完全滑过去
            if(currentOffsetX - startOffsetX == scrollViewW) {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {//右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
        }
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//对外暴露的方法
extension PageContentView {
    func setCurrentIndex(index : Int) {
        isFobidScrollDelegate = true
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
