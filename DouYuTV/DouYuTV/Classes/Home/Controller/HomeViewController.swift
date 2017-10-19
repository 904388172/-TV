//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/19.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit
private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    //MARK: - 懒记载属性(闭包的形式)
    private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatebarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    //MARK: - 懒记载
    private lazy var pageContentView: PageContentView = {
        [weak self] in
        let contentH = kScreenH - kStatebarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatebarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //确定所有的子控件
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        //设置UI界面
        setUpUI()
    }
}
    
// MARK: - 设置UI界面
extension HomeViewController {
    private func setUpUI() {
        //1.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //2.设置导航栏
        setupNavigationBar()
        
        //3.添加titleView
        view.addSubview(pageTitleView)
        
        //4.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar() {
        //左边按钮
        //调用自己封装的构造方法创建UIBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右边的items
        let size = CGSize(width: 40, height: 40)
        /*
         //类方法封装
         let historyItem = UIBarButtonItem.createItem(imageName:"image_my_history", highImageName: "Image_my_history_click", size: size)
         
         let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
         
         let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
         */
        
        //构造函数方法封装
        let historyItem = UIBarButtonItem(imageName:"image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}


