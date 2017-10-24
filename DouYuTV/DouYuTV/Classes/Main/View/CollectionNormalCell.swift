//
//  CollectionNormalCell.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    //MARK: - 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK：- 定义模型属性
    override var anchor: AncherModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}
