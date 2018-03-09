//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/1/31.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kCycleViewH : CGFloat = kScreenW / 8 * 3
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    //懒加载属性
    private lazy var recommendViewModel : RecommendViewModel = {
        let recommendViewModel = RecommendViewModel()
        return recommendViewModel
    }()
    
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

    override func setupUI() {
        //1.调用父类方法
        super.setupUI()
        //2.将cycleView添加到控制器的view中
        collectionView.addSubview(cycleView)
        //3.添加gameView
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        baseVM = recommendViewModel
        //请求推荐数据
        recommendViewModel.requestData {
            //1.展示推荐数据
            self.collectionView.reloadData()
            //2.将数据传递给GameView
            var groups = self.recommendViewModel.anchorGroups
            //移除前两项
            groups.removeFirst()
            groups.removeFirst()
            //添加更多选项
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
            //数据请求完成
            self.loadDataFinished()
        }
        //请求轮播数据
        recommendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1.取出prettycell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
            //2.设置数据
            prettyCell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchorModels[indexPath.item]
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height:kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
