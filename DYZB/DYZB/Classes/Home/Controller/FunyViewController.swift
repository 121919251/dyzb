//
//  FunyViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/8.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunyViewController: BaseAnchorViewController {
    fileprivate lazy var funyVM : FunyViewModel = FunyViewModel()
    
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        //给父类ViewModel赋值
        baseVM = funyVM
        funyVM.loadFunyData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}

extension FunyViewController {
    
}
