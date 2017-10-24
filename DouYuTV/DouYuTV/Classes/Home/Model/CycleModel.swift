//
//  CycleModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/24.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    /**
     swift 4.0字典转模型时需要在变量前面家@objc，不然会转不成功
     */
    //标题
    @objc var title: String = ""
    //展示的图片地址
    @objc var pic_url: String = ""
    //主播信息对应的字典
    @objc var room: [String: NSObject]? {
        didSet {
            guard let room = room else { return }
            ancher = AncherModel(dict: room)
        }
    }
    
    //主播信息对应的模型对象
    var ancher: AncherModel?
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    //防止出错，重写该方法（有些数据没有转）
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
