//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by GS on 2017/10/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

//主播模型
class AnchorGroup: NSObject {
    /**
     swift 4.0字典转模型时需要在变量前面家@objc，不然会转不成功
     */
    //该组中对应的房间信息
    @objc var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchers.append(AncherModel(dict: dict))
            }
        }
    }
    //标题
    @objc var tag_name: String = ""
    //图标
    @objc var icon_name: String = "home_header_normal"
    //定义主播的模型对象数组（默认不转）
    lazy var anchers: [AncherModel] = [AncherModel]()
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    //重写构造函数
    override init() {
    }
    
    //防止出错，重写该方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    /*
    //自己转
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String: NSObject]] {
                for dict in dataArray {
                    anchers.append(AncherModel(dict: dict))
                }
            }
        }
    }
     */
}
