//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/6.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kCellId = "kCellId"
private let kEdgeMargin : CGFloat = 10

class RecommendGameView: UIView {
    //定义数据的属性
    var groups : [BaseGameModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kCellId)
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
    }
}

//提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//遵守UICollectionView数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        return cell
    }
}
