//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 郭洋 on 2018/2/3.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    //定义模型
    var anchor : AnchorModel? {
        didSet {
            //校验模型是否有值
            guard let anchor = anchor else {return}
            //取出在线人数显示值
            var onlineStr : String = ""
            if(anchor.online >= 10000) {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //昵称的显示
            nicknameLabel.text = anchor.nickname
            //显示图片
            guard let imageUrl = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: imageUrl)
        }
    }
}
