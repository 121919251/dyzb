//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/5.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

let kCycleCellId = "kCycleCellId"

class RecommendCycleView: UICollectionViewCell {
    //定义属性
    var cycleTimer : Timer?
    var cycleModels: [CycleModel]? {
        didSet {
            //1.刷新CollectionView
            collectionView.reloadData()
            //2.刷新pageControl
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //4.添加滚动timer
            removeCycleTimer()
            addCycleTimer()
        }
    }
    //定义控件
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
    }
    
    override func layoutSubviews() {
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//提供一个快速创建view的方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//遵守UICollectionView的数据协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}

//遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = collectionView.contentOffset.x + scrollView.bounds.width / 2
        pageControl.currentPage = Int(offset / scrollView
            .bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//对定时器的操作方法
extension RecommendCycleView {
    //添加定时器
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    //移除定时器
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc private func scrollToNext() {
        // 1.获取滚动的偏移量
        var currentOffsetX = Int(collectionView.contentOffset.x)
        let collectionW = Int(collectionView.bounds.width)
        if currentOffsetX % collectionW > 0 {
            currentOffsetX -= currentOffsetX % collectionW
        }
        let offsetX = currentOffsetX + Int(collectionView.bounds.width)
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
