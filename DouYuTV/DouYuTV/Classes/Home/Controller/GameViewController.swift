//
//  GameViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/25.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

private let kEndgMargin: CGFloat = 10
//private let kItemW: CGFloat = (kScreenW - 2 * kEndgMargin) / 3
//private let kItemH: CGFloat = kItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50
private let kTopViewH: CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"
//private let kTopViewID = "kHeaderViewID"

class GameViewController: UIViewController {

    //MARK: - 懒加载属性
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    
    //懒加载collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        //弱引用
        [unowned self] in
        
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 90)
        // 行间距
        layout.minimumLineSpacing = 0
        //item之间的间距
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(0, kEndgMargin, 0, kEndgMargin)
        //设置collectionView的headerView
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //设置collectionView的高度和宽度随着父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //xib方式注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        //注册头部headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        return collectionView
    }()
    
    //懒加载topHeaderView
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kTopViewH), width: kScreenW, height: kHeaderViewH)
        
        headerView.titlelabel.text = "常用"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    //懒加载topView
    fileprivate lazy var topView: RecomendGameView = {
        let topView = RecomendGameView.recomendGameView()
        topView.frame = CGRect(x: 0, y: -kTopViewH, width: kScreenW, height: kTopViewH)
        
//        headerView.titlelabel.text = "常用"
//        headerView.iconImageView.image = UIImage(named: "Img_orange")
//        headerView.moreBtn.isHidden = true
        return topView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - 设置UI
extension GameViewController {
    func setUpUI() {
        view.addSubview(collectionView)
        
        //1.加载数据
        loadData()
        
        //2.添加顶部的headerView
        collectionView.addSubview(topHeaderView)
        
        //3.添加顶部的topView
        collectionView.addSubview(topView)
        
        //4.设置collectionView 的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kTopViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension GameViewController {
    func loadData() {
        self.gameVM.requestAllGameData {
            //展示全部游戏
            self.collectionView.reloadData()
            
            //展示常用游戏(全部游戏的前十条)  取一个数组的区间，然后转成数组
            let groups = self.gameVM.games[0..<10]
            self.topView.groups = Array(groups)
        }
    }
}

//MARK: - UICollectionView dataSource
extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
                
        cell.baseGame = gameVM.games[indexPath.item]
        
        //随机颜色
//        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    //headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //给headerView设置属性
        headerView.titlelabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}









