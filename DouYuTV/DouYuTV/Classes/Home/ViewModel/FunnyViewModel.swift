//
//  FunnyViewModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/27.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class FunnyViewModel {
    //娱乐数组
    lazy var funnyGroups: [AnchorGroup] = [AnchorGroup]()
}

//MARK: - 发送网络请求
extension FunnyViewModel {
    
    //请求趣玩的数据(这个数据不是分组数据，字典转模型的时候跟其他的有区别)
    func requestFunnyData(finishCallback: @escaping () ->()) {
        //http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offset=0
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit": "30", "offset": "0"]) { (result) in
            
            //1.获取整体字典数据
            guard let resultDict = result as? [String: NSObject] else { return }
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            
            var groups: [AncherModel] = [AncherModel]()
            //3.字典转模型
            for dict in dataArray {
                groups.append(AncherModel(dict: dict))
            }
            var gameArray = [String]()
            for model in groups {
                gameArray.append(model.game_name)
            }
            var result = Array(Set(gameArray))
            
            for i in 0..<result.count {
                
                var iconUrl : String = ""
                let gg = AnchorGroup()
                for model in groups {
                    if result[i] == model.game_name {
                        iconUrl = model.game_url
                        gg.anchers.append(model)
                    }
                }
                gg.tag_name = result[i]
                gg.icon_url = iconUrl
                self.funnyGroups.append(gg)
            }

            finishCallback()
        }
    }
}
