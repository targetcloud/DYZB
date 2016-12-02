//
//  BaseCollectionViewCell.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/9.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }

            var onlineStr : String = ""
            if anchor.online >= 10000 {
//                onlineStr = "\(Int(anchor.online / 10000))万"
                onlineStr = String(format:"%.1f万",Float(anchor.online) / 10000)
            } else {
                onlineStr = "\(anchor.online)"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
}
