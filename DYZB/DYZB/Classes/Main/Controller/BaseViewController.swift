//
//  BaseViewController.swift
//  DYZB
//
//  Created by 郭洋 on 2018/3/8.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //定义属性
    var contentView : UIView?
    
    //懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        //1.隐藏内容的view
        contentView?.isHidden = true
        //2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        //3.给animImageView执行动画
        animImageView.startAnimating()
        //4.设置view背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
}

extension BaseViewController {
    func loadDataFinished() {
        //1.停止动画
        animImageView.stopAnimating()
        //2.隐藏imageview
        animImageView.isHidden = true
        //3.显示内容view
        contentView?.isHidden = false
    }
}
