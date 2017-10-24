//
//  CollectionBaseCell.swift
//  DouYuTV
//
//  Created by GS on 2017/10/24.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //MARK: - 定义模型属性
    var anchor: AncherModel? {
        didSet {
            //监听改变
            //0.检验模型是否有值
            guard let anchor = anchor else { return }
    
            //1.显示在线人数
            var onlineStr: String = ""
            if anchor.online >= 10000 {
            onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
            onlineStr = "\(anchor.online)万在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
        
            //2.昵称
            nickNameLabel.text = anchor.nickname
        
            //3.图片
            guard let iconUrl = NSURL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconUrl as URL)
        }
    }
}
