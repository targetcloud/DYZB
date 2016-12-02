//
//  CollectionNormalCell.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/7.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class CollectionNormalCell: BaseCollectionViewCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


