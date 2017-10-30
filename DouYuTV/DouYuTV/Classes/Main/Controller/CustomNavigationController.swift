//
//  CustomNavigationController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/30.
//  Copyright © 2017年 Demo. All rights reserved.
//

/**
     自定义导航控制器
 */

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //重写push的方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
