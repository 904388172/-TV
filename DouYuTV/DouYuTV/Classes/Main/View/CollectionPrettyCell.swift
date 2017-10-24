//
//  CollectionPrettyCell.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    //MARK: - 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK：- 定义模型属性
    override var anchor: AncherModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    

}
