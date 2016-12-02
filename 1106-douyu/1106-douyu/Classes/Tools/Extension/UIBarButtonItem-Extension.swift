//
//  UIBarButtonItem-Extension.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/6.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    /*
    class func createItem(imageName : String, highlightedImage : String , size : CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : highlightedImage), for: .highlighted)
        btn.frame = CGRect (origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    convenience init(imageName : String, highlightedImage : String = "" , size : CGSize = CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highlightedImage != ""{
            btn.setImage(UIImage(named : highlightedImage), for: .highlighted)
        }
        if size != CGSize.zero{
            btn.frame = CGRect (origin: CGPoint.zero, size: size)
        }else
        {
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
