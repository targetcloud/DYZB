//
//  FunnyVM.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/11.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class FunnyVM: BaseVM {

}

extension FunnyVM {
    func requestData(finishedCallback : @escaping () -> ()) {
//        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
        
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?client_sys=ios&identification=393b245e8046605f6f881d415949494c",finishedCallback: finishedCallback)
    }
}
