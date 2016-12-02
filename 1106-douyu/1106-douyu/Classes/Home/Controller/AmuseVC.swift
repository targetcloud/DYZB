//
//  AmuseVC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/10.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class AmuseVC: BaseAnchorVC {

    fileprivate lazy var amuseVM : AmuseVM = AmuseVM()
    fileprivate lazy var menuView : MenuView = {
        let menuView = MenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)//设置collectionView的-y,放置menuView
        return menuView
    }()
}

extension AmuseVC {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)//设置内边距
    }
}

extension AmuseVC{
    override func loadData() {
        baseVM = amuseVM
        amuseVM.requestData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            self.loadDataFinished()
        }
    }
}
