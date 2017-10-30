//
//  FunnyViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/26.
//  Copyright © 2017年 Demo. All rights reserved.
//

/**
    趣玩界面
 */

import UIKit

//MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3*kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kHeaderViewH: CGFloat = 50
private let kMenuViewH: CGFloat = 200

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

//和娱乐界面一样(后面看能否单独抽出一个基类来)
class FunnyViewController: BaseViewController {

    private lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    
    //MARK: - 懒加载属性(创建CollectionView)
    fileprivate lazy var collectionView: UICollectionView = {
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
        //        collectionView.delegate = self
                
        //注册cell（普通）
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //使用Xib注册headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        //collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    //创建菜单view
    private lazy var menuView: MenuView = {
        let menuView = MenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        menuView.backgroundColor = UIColor.white
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setUpUI()
        
        //发送网络请求
        loadData()
    
    }
    
    //MARK: - 由于继承的有基类的视线方法，所以必须写在这里面不能写在extension里面
    override func setUpUI() {
        //1.先给父类中内容view的引用进行赋值
        contentView = collectionView
        
        //2.添加UI
        addUI()
        
        //3.调用super.setUpUI()
        super.setUpUI()
        
    }
}
//MARK: - 请求数据
extension FunnyViewController {
    private func loadData() {
        
        //请求趣玩数据
        funnyVM.requestFunnyData {
            self.collectionView.reloadData()
            
            //处理数据
            let tempGroups = self.funnyVM.funnyGroups
            //数据传给menuView
            self.menuView.groups = tempGroups
            
            //MARK: - 调用父类的数据请求完成
            self.loadDataFinish()
        }
    }
}

//MARK: - 添加UI界面
extension FunnyViewController {
    
    func addUI() {
    
        //
        view.addSubview(collectionView)
        
        //menuView添加到collectionView
        collectionView.addSubview(menuView)
    }
}

//MARK: - UICOllectionView的dataSource
extension FunnyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return funnyVM.funnyGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyVM.funnyGroups[section].anchers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = funnyVM.funnyGroups[indexPath.section].anchers[indexPath.item]
        
        //随机颜色
//        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    //headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView

        //给headerView设置属性
        headerView.group =  funnyVM.funnyGroups[indexPath.section]

        return headerView
    }
}

