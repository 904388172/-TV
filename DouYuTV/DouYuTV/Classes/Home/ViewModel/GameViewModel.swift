//
//  GameViewModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/25.
//  Copyright © 2017年 Demo. All rights reserved.
//

/**
     游戏界面的数据模型
 */

import UIKit

class GameViewModel {
    //游戏数组
    lazy var games: [GameModel] = [GameModel]()

}

//MARK: - 发送网络请求
extension GameViewModel {
    //请求全部游戏
    func requestAllGameData(finishCallback: @escaping () -> ()) {
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            //将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else { return }
            //根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else { return }
            
            //字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            //完成回调
            finishCallback()
        }
    }
}
