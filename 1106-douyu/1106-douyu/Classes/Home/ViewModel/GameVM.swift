//
//  GameVM.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/10.
//  Copyright © 2016年 targetcloud. All rights reserved.
//
/*
import UIKit

class GameVM {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameVM {
    func requestData(_ finishedCallback : @escaping () -> ()) {
        HttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            for dict in arr {
                self.games.append(GameModel(dict: dict))
            }
            finishedCallback()
        }
    }
}
*/
import UIKit

class GameVM: BaseVM {
    
}

extension GameVM {
    func requestData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?client_sys=ios&identification=ba08216f13dd1742157412386eee1225", finishedCallback: finishedCallback)
    }
}


