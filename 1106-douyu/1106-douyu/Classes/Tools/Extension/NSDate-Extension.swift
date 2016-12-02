//
//  NSDate-Extension.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/9.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String {
        return "\(NSDate().timeIntervalSince1970)"//interval
    }
}
