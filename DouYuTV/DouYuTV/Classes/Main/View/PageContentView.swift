//
//  PageContentView.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(cintentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    //MARK: - 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startOffsetX: CGFloat = 0
    //禁止滑动
    private var isForbidScrollDelegate: Bool = false
    
    weak var delegate: PageContentViewDelegate?
    
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
        collectionView.delegate = self
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

//MARK: - 遵守UICollectionView delegate
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //2.获取需要的数据
        var progress: CGFloat = 0  //比例
        var sourceIndex: Int = 0  //开始的index
        var targetIndex: Int = 0  //目标的index
        
        //3.判断时左滑还是右滑
        let currentOffsetx = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetx > startOffsetX {
            //左滑
            //floor()   取整函数
            progress = currentOffsetx / scrollViewW - floor(currentOffsetx / scrollViewW)
            sourceIndex = Int(currentOffsetx / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = targetIndex - 1
            }
            
            //如果完全滑过去
            if currentOffsetx - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {
            //右滑
            progress = 1 - (currentOffsetx / scrollViewW - floor(currentOffsetx / scrollViewW))
            targetIndex = Int(currentOffsetx / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = sourceIndex - 1
            }
        }
        
        //4.将progress／sourceIndex／targetIndex传递给titleView
//        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(cintentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    
}
//MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        //1记住需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        //滚动正确的位置
        let offsetx = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetx, y: 0), animated: false)
    }
}







