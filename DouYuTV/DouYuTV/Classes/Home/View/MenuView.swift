//
//  MenuView.swift
//  DouYuTV
//
//  Created by GS on 2017/10/26.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class MenuView: UIView {

    //MARK: - 定义属性
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //xib方式注册cell
        collectionView.register(UINib(nibName: "CollectionMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //必须在这个方法里面布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        // 行间距
        layout.minimumLineSpacing = 0
        //item之间的间距
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
    }
}

//MARK: - 从xib中快速创建的类方法
extension MenuView {
    class func menuView() -> MenuView {
        return Bundle.main.loadNibNamed("MenuView", owner: nil, options: nil)?.first as! MenuView
    }
}

//MARK: - UICollectionView dataSource
extension MenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pageNum = (groups!.count - 1) / 8 + 1
        
        if pageNum <= 1 {
            pageControl.isHidden = true
        } else {
            //只显示两个
//            pageNum = 2
            
            //显示多个
            pageControl.numberOfPages = pageNum
        }
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! CollectionMenuCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    //像里面的cell传递数据
    private func setupCellDataWithCell(cell: CollectionMenuCell, indexPath: IndexPath) {
        //0页：0~7
        //1页：8~15
        //2页：16~23
        //1.取出起始位置,终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2.判断越界问题
        if endIndex > (groups?.count)! - 1 {
            endIndex = (groups?.count)! - 1
        }
        
        //3.取出数据，赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }

}
//MARK: - UICollectionView Delegate
extension MenuView: UICollectionViewDelegate {

    //监听滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //计算pageControl的currentIndex
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}








