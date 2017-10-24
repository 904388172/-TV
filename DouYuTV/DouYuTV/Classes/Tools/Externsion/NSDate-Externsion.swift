//
//  NSDate-Externsion.swift
//  DouYuTV
//
//  Created by GS on 2017/10/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

import Foundation

extension NSDate {
    //MARK: - 获取当前时间（秒来计算），返回字符串
    class func getCurrentTime() ->String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
