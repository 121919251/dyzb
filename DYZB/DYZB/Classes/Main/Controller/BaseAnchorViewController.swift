//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/3.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH : CGFloat = kItemW * 3 / 4
let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeadViewH : CGFloat = 50

private let kNormalCellId = "kNormalCellId"
let kPrettyCellId = "kPrettyCellId"
private let kHeadViewId = "kHeadViewId"

class BaseAnchorViewController: BaseViewController {
    //定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = { [unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        
        //2.创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewId)
        
        return collectionView
        }()
    
    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    func loadData() {
    }
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}

//遵守UICollectionView的数据源
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseVM == nil {
            return 1
        }
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseVM == nil {
            return 20
        }
        return baseVM.anchorGroups[section].anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
        if baseVM == nil {
            return cell
        }
        //2.给cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchorModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewId, for: indexPath) as! CollectionHeaderView
        if baseVM == nil {
            return headerView
        }
        //2.给headerView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

//遵守UICollectionViewDelegate代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchorModels[indexPath.item]
        //2.判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? presentNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc() {
        //1.创建showRoomVc
        let showRoomVc = RoomShowViewController()
        //2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
    
    private func presentNormalRoomVc() {
        //1.创建normalRoomVc
        let normalRoomVc = RoomNormalViewController()
        //2.以Push方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}
