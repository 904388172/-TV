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

private let kGameCellID = "kGameCellID"

class GameViewController: UIViewController {

    //MARK: - 懒加载属性
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    
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
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //设置collectionView的高度和宽度随着父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //xib方式注册
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
        
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
        
        //加载数据
        loadData()
    }
}

//MARK: - 请求数据
extension GameViewController {
    func loadData() {
        self.gameVM.requestAllGameData {
            self.collectionView.reloadData()
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
}









