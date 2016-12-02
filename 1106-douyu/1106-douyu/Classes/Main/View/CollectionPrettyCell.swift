//
//  CollectionPrettyCell.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/7.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class CollectionPrettyCell: BaseCollectionViewCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
