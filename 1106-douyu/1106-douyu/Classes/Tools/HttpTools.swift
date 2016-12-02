//
//  HttpTools.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/7.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class HttpTools {
    //参数的finishedCallback闭包在26行使用了，而使用的环境又是一个闭包，则需要加@escaping
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallback(result)
        }
    }
}
