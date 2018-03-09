//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/7.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

private let kGameCellId = "kGameCellId"
class AmuseMenuViewCell: UICollectionViewCell {
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
