//
//  CollectionCycleCell.swift
//  DouYuTV
//
//  Created by GS on 2017/10/24.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titlelabel: UILabel!
    
    //MARK: - 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titlelabel.text = cycleModel?.title
            
            let iconUrl = NSURL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconUrl as URL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
