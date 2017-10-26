//
//  BaseGameModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/25.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

//基类
class BaseGameModel: NSObject {
    //游戏名
    @objc var tag_name: String = ""
    //游戏对应图片的url
    @objc var icon_url: String = ""
    
    //重写构造函数
    override init() {
    }
    
    //自定义构造函数
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
