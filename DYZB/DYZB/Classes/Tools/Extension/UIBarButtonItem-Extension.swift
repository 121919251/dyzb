//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 郭洋 on 2018/1/30.
//  Copyright © 2018年 鹏伍科技. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*class func createItem(imageName : String, highLight : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : highLight), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }*/
    
    //便利构造函数 1>convenience开头 2>在构造函数中必须明确的调用一个设计构造函数(self)
    convenience init(imageName : String, highLight : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        if(highLight != "") {
            btn.setImage(UIImage(named : highLight), for: .highlighted)
        }
        if(size == CGSize.zero) {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView : btn)
    }
}
