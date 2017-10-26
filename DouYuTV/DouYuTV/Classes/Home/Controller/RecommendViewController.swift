//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3*kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50
private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    //MARK: - 懒加载属性
    private lazy var recomendVM: RecommendViewModel = RecommendViewModel()
    
    //懒加载collectionView
    private lazy var collectionView: UICollectionView = {
        [weak self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        // 行间距
        layout.minimumLineSpacing = 0
        //item之间的间距
        layout.minimumInteritemSpacing = kItemMargin
        //cell上面有组头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //给layout设置内边距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        //设置collectionView的高度和宽度随着父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //代理
        collectionView.dataSource = self
        collectionView.delegate = self
        
        /*
        //注册cell(注册的最普通的cell)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //注册cell的headerView(注册的最普通的header)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
         */
        //注册cell（普通）
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //注册cell（颜值）
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //使用Xib注册headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        
        return collectionView
    }()
    
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()
    
    private lazy var gameView: RecomendGameView = {
        let gameView = RecomendGameView.recomendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        gameView.backgroundColor = UIColor.red
        
        return gameView
    }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setUpUI()
        
        //发送网络请求
        loadData()
    }
}

//MARK: - 请求数据
extension RecommendViewController {
    private func loadData() {
        //MVVM 模式获取网络请求
        recomendVM.requestData {
            //1.展示推荐数据
            self.collectionView.reloadData()
            
            //2.将数据传递个GameView
            var groups = self.recomendVM.ancherGroups
            //2.1.先移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            //2.2添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        
        //请求轮播数据
        recomendVM.requestCycleData {
            self.cycleView.cycleModels = self.recomendVM.cycleModels
        }
    }
}

//MARK: - 设置UI界面
extension RecommendViewController {
    private func setUpUI() {
        //1.将UICollectionView添加到控制器中
        view.addSubview(collectionView)
        
        //2.将cycleView添加到collectionView中
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

//MARK: - 遵守UICollectonView的协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 12  //12组
        return recomendVM.ancherGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recomendVM.ancherGroups[section]
        return group.anchers.count
//        //每组有几个
//        if section == 0 {
//            return 8
//        }
//        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //1.取出模型对象
        let group = recomendVM.ancherGroups[indexPath.section]
        let anchor = group.anchers[indexPath.item]
        
        //2.定义cell
        var cell: CollectionBaseCell!
        
        //3.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        //4.将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //取出模型
        headerView.group = recomendVM.ancherGroups[indexPath.section]
        
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}










