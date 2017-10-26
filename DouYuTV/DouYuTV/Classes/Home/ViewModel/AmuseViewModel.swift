//
//  AmuseViewModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/26.
//  Copyright © 2017年 Demo. All rights reserved.
//

/**
    娱乐界面的数据模型
 */

import UIKit

class AmuseViewModel {
    //娱乐数组
    lazy var amuses: [AmuseModel] = [AmuseModel]()
}

//MARK: - 发送网络请求
extension AmuseViewModel {
    //请求娱乐数据
    func requestAmuseData(finishCallback: @escaping () ->()) {
    
        //请求娱乐的数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil) { (result) in

            //1.获取整体字典数据
            guard let resultDict = result as? [String: NSObject] else { return }

            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }

            //3.字典转模型
            for dict in dataArray {
                self.amuses.append(AmuseModel(dict: dict))
            }

            finishCallback()
        }
    }
}
