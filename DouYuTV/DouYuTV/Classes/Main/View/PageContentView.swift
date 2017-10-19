//
//  PageContentView.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    //MARK: - 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    
    //MARK: - 懒加载属性(闭包形式)
    private lazy var collectionView: UICollectionView = {
        [weak self] in  //防止强引用(闭包里面使用self时)
       //创建layout
        var layout = UICollectionViewFlowLayout()
        //强制解包
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = self
        //注册collection
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Mark: - 扩展view
extension PageContentView {
    private func setUpUI() {
        //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - 遵守UICollectionView dataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        //给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}








