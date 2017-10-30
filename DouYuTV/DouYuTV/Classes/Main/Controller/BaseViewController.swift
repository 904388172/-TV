//
//  BaseViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/27.
//  Copyright © 2017年 Demo. All rights reserved.
//


/**
     首页首次进来会有加载图
 */

import UIKit

class BaseViewController: UIViewController {

    //MARK: - 定义属性
    var contentView: UIView?
    
    //MARK: - 懒加载属性
    fileprivate lazy var animImageView: UIImageView = {
        [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        
        //动画
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        //顶部和底部拉伸
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 由于是基类，有子类继承会重写这个方法，所以必须写在这里面不能写在extension里面
    func setUpUI() {
        //1.先隐藏内容的View
        contentView?.isHidden = true
        
        //2.添加执行动画的imageView,然后重写子类的setUpUI方法，需要添加super
        view.addSubview(animImageView)
        
        //3.给animImageView执行动画
        animImageView.startAnimating()
        
        //4.设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    //MARK: - 请求数据完成隐藏动画
    func loadDataFinish() {
        
        //1.停止动画
        animImageView.stopAnimating()
        
        //2.隐藏animImageView
        animImageView.isHidden = true
        
        //3.显示内容的view
        contentView?.isHidden = false
    }
}

