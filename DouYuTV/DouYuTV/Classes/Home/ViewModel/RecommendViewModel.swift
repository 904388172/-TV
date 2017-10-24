//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by GS on 2017/10/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //MARK: - 懒加载属性
    //(所有数据)数组
    lazy var ancherGroups: [AnchorGroup] = [AnchorGroup]()
    
    //大数据
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    //颜值
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

//MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback: @escaping () ->()) {
        //1.定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime() as NSString]
        
        //2.线程（防止请求到的数据先后不一致导致显示不一致,几个请求都回来之后才处理结果）
        let dGroup = DispatchGroup()
        
        //3.请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime() as NSString]) { (result) in
            //将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else { return }
            //根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else { return }
            //创建组(有全局的)
            //设置组属性
            self.bigDataGroup.tag_name = "推荐"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //遍历数组。获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let anchor = AncherModel(dict: dict)
                self.bigDataGroup.anchers.append(anchor)
            }
            
            //离开组
            dGroup.leave()
        }
        
        //4.请求颜值数据
        //https://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1474252024
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else { return }
            //根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else { return }
            
            //创建组(有全局的)
            //设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //遍历数组。获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let anchor = AncherModel(dict: dict)
                self.prettyGroup.anchers.append(anchor)
            }
            
            //离开组
            dGroup.leave()
        }
        
        //5.请求后面的数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else { return }
            //根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else { return }
            //遍历数组。获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.ancherGroups.append(group)

            }
//            for group in self.ancherGroups {
//                for ancher in group.anchers {
////                    print(ancher.nickname)
//                }
//            }
            
            //离开组
            dGroup.leave()
        }
        
        //6.所有的数据都请求到之后进行排序
        //离开组
        dGroup.notify(queue: DispatchQueue.main) {
            print("所有数据都请求到")
            //排序
            self.ancherGroups.insert(self.prettyGroup, at: 0)
            self.ancherGroups.insert(self.bigDataGroup, at: 0)
            
            //拿到所有数据之后回掉
            finishCallback()
        }
    }
}
