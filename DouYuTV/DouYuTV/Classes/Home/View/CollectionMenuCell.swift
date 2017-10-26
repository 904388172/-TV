//
//  CollectionMenuCell.swift
//  DouYuTV
//
//  Created by GS on 2017/10/26.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

private let kGameMenuCellID = "kGameMenuCellID"

private let kMenuCellW: CGFloat = kScreenW / 4

class CollectionMenuCell: UICollectionViewCell {

    //定义属性(数组模型)
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //从Xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册Cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameMenuCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //必须在这个方法里面布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let kMenuCellH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: kMenuCellW, height: kMenuCellH)
        
        // 行间距
        layout.minimumLineSpacing = 0
        //item之间的间距
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

//MARK: - UICollectionView dataSource
extension CollectionMenuCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameMenuCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups?[indexPath.item]
        
        return cell
    }
}
