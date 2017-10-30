//
//  RoomNormalViewController.swift
//  DouYuTV
//
//  Created by GS on 2017/10/30.
//  Copyright © 2017年 Demo. All rights reserved.
//

/**
     一般直播界面
 */

import UIKit

class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    //将要显示控制器时
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        /*
         已经存在自定义全屏手势了就不需要系统的手势了
         
        //依然保存手势（可以滑动返回）
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
         */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
    }
    
    //将要消失控制器时显示导航栏
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
