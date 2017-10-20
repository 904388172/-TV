//
//  NetworkTools.swift
//  AlamofireTest
//
//  Created by GS on 2017/10/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

/* 封装请求 */

import UIKit
//import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type: MethodType, URLString: String, parameters: [String: NSString]? = nil, finishedCallback: @escaping (_ result: Any) ->()) {
        
//        //获取类型
//        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
//        //发送网络请求
//        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//            //获取结果
//            guard let result = response.result.value else {
//                print(response.result.error!)
//                return
//            }
//            print(result)
//            //将结果回调出去
//            finishedCallback(result)
//        }
    }
}
