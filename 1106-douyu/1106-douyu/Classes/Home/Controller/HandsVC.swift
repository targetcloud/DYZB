//
//  HandsVC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/11.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class HandsVC: BaseAnchorVC {

    fileprivate lazy var handsVM : HandsVM = HandsVM()
    fileprivate lazy var menuView : MenuView = {
        let menuView = MenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)//设置collectionView的-y,放置menuView
        return menuView
    }()

}

extension HandsVC {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)//设置内边距
    }
}

extension HandsVC{
    override func loadData() {
        baseVM = handsVM
        handsVM.requestData {
            self.collectionView.reloadData()
            
            var tempGroups = Array(self.handsVM.anchorGroups[1...15])// 0...15 & tempGroups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多分类"
            tempGroups.append(moreGroup)
            self.menuView.groups = tempGroups
            
            self.loadDataFinished()
        }
    }
}

