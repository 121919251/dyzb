//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/5.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义模型属性
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
