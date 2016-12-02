//
//  BaseVM.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/9.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class BaseVM {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        HttpTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            if isGroupData {
                for dict in arr {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else  {
                let group = AnchorGroup()
                for dict in arr {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            finishedCallback()
        }
    }
}
