//
//  CollectionHeaderView.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK: - 控件属性
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - 定义一个模型属性
    var group: AnchorGroup? {
        didSet {  //监听改变
            titlelabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal") //是一个可选只，？？表示如果没有值就传后面的默认值
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
