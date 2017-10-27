//
//  AncherModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class AncherModel: NSObject {
    //房间ID
    @objc var room_id: Int = 0
    //房间显示图片对应的url
    @objc var vertical_src: String = ""
    //判断是手机直播还是电脑直播
    //0：电脑直播，1:手机直播
    @objc var isVertical: Int = 0
    //房间名称
    @objc var room_name: String = ""
    //主播名称
    @objc var nickname: String = ""
    //观看人数
    @objc var online: Int = 0
    //所在城市
    @objc var anchor_city: String = ""
    //游戏类型图片地址
    @objc var game_url: String = ""
    //游戏类型
    @objc var game_name: String = ""
    
    //重写构造函数
    override init() {
        super.init()
        
    }
    
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
