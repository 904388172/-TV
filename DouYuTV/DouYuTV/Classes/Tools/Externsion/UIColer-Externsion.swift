//
//  UIColer-Externsion.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

//扩展类
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha:1.0)
    }
    
    //随机颜色
    class func randomColor() ->UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
}
