//
//  RecommendVM.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/9.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class RecommendVM :BaseVM {
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var hottestGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecommendVM {
    func requestData(_ finishCallback : @escaping () -> ()){
        let parameters = ["limit" : "4", "offset" : "0","client_sys" : "ios", "time" : NSDate.getCurrentTime()]
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        HttpTools.requestData(.post, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["client_sys" : "ios","time" : NSDate.getCurrentTime()]) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            self.hottestGroup.tag_name = "最热"
            self.hottestGroup.icon_name = "home_header_hot"
            for dict in arr {
                let anchor = AnchorModel(dict: dict)
                self.hottestGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        HttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "columnYanzhiIcon"
            for dict in arr {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()//dispatch_group_enter(dispatchGroup)
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            self.anchorGroups.remove(at: 1)
            dispatchGroup.leave()//dispatch_group_leave(dispatchGroup)
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {//dispatch_group_notify(dispatchGroup,dispatch_get_main_queue()){
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.hottestGroup, at: 0)
            finishCallback()
        }
    }
    
    func requestCycleData(_ finishCallback : @escaping () -> ()){
        HttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.401"]) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            for dict in arr {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}
