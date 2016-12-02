//
//  AnchorGroup.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/9.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    var icon_name : String = "home_header_normal"
    var room_list : [[String : Any]]? {
        didSet {
            guard let room_list2 = room_list else { return }
            for dict in room_list2 {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
}
