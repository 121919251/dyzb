//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/7.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kMenuCellId = "kMenuCellId"

class AmuseMenuView: UIView {
    //定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {return 0}
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellId, for: indexPath) as! AmuseMenuViewCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath) {
        //1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        //3.取出数据，并赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
