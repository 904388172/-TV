//
//  RecomendGameView.swift
//  DouYuTV
//
//  Created by GS on 2017/10/24.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin: CGFloat = 10

class RecomendGameView: UIView {
    
    //MARK: - 定义数据的属性
    var groups: [AnchorGroup]? {
        didSet {
            //1.先移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //2.刷新collectionView
            collectionView.reloadData()
        }
    }

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置控件不随着父空间拉伸而拉伸
        autoresizingMask = UIViewAutoresizing.flexibleRightMargin
        
        //xib方式注册
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //collectionView添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
    }
    
    override func layoutSubviews() {
        //设置collectiView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 90)
        
        // 行间距
        layout.minimumLineSpacing = 0
        //item之间的间距
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
    }

}

//MARK: - 提供一个快速创建view的类方法
extension RecomendGameView {
    class func recomendGameView() -> RecomendGameView {
        return Bundle.main.loadNibNamed("RecomendGameView", owner: nil, options: nil)?.first as! RecomendGameView
    }
}

//MARK: - 遵守uicollectionView的数据源协议
extension RecomendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        
        return cell
    }
}
//MARK: - 遵守uicollectionView的代理协议
extension RecomendGameView: UICollectionViewDelegate {
    
}
