//
//  UIBarButton-Externsion.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

//扩展
extension UIBarButtonItem {
    /*
     //扩展类方法
     class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
     let btn = UIButton(type: UIButtonType.custom)
     btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
     btn.setImage(UIImage(named: highImageName), for: UIControlState.highlighted)
     btn.frame = CGRect(origin: CGPoint.zero, size: size)
     return UIBarButtonItem(customView: btn)
     }
     */
    
    //一般扩展都是扩展成构造函数，很少扩展成类方法
    //便利构造函数:1> convenience开头  2> 在构造函数中必须明确调用一个设计的构造函数（self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        //创建UIButton
        let btn = UIButton(type: UIButtonType.custom)
        
        //设置button的图片
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: UIControlState.highlighted)
        }
        
        //设置button的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //创建uibarbuttonItem
        self.init(customView: btn)
    }
}
