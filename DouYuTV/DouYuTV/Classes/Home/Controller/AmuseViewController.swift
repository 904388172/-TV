//
//  AmuseViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/26.
//  Copyright © 2017年 Demo. All rights reserved.
//

/**
     娱乐界面
 */
import UIKit

//MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3*kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kHeaderViewH: CGFloat = 50
private let kMenuViewH: CGFloat = 200

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class AmuseViewController: BaseViewController {

    private lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    
    //MARK: - 懒加载属性
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
        
        //注册cell（普通）
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //注册cell（颜值）
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //使用Xib注册headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        //collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    private lazy var menuView: MenuView = {
        let menuView = MenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setUpUI()
        
        //发送网络请求
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//MARK: - 添加UI界面
extension AmuseViewController {
    func addUI() {
        
        //
        view.addSubview(collectionView)
        
        //menuView添加到collectionView
        collectionView.addSubview(menuView)
    }
}

//MARK: - 请求数据
extension AmuseViewController {
    private func loadData() {

        //请求娱乐数据
        amuseVM.requestAmuseData {
            self.collectionView.reloadData()
            
            //处理数据(删除最热)
            var tempGroups = self.amuseVM.amuses
            tempGroups.removeFirst()
            
            //数据传给menuView
            self.menuView.groups = tempGroups
            
            //MARK: - 调用父类的数据请求完成
            self.loadDataFinish()
        }
    }
}

//MARK: - UICOllectionView的dataSource
extension AmuseViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.amuses.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.amuses[section].anchers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = amuseVM.amuses[indexPath.section].anchers[indexPath.item]
//        //随机颜色
//        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    //headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //给headerView设置属性
        headerView.group = amuseVM.amuses[indexPath.section]
        
        return headerView
    }
}








