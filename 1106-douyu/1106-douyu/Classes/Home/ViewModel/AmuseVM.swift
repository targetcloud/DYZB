//
//  AmuseVM.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/10.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class AmuseVM: BaseVM {

}

extension AmuseVM {
    func requestData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
