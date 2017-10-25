//
//  CollectionGameCell.swift
//  DouYuTV
//
//  Created by GS on 2017/10/24.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 定义模型属性
    var group : AnchorGroup? {
        didSet {            
            titleLabel.text = group?.tag_name
            let iconUrl = NSURL(string: group?.icon_url ?? "")!
            iconImageView.kf.setImage(with: iconUrl as URL, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
