//
//  FunnyVC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/11.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit
//private let kTopMargin : CGFloat = 8

class FunnyVC: BaseAnchorVC {

    fileprivate lazy var funnyVM : FunnyVM = FunnyVM()
    fileprivate lazy var menuView : MenuView = {
        let menuView = MenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)//设置collectionView的-y,放置menuView
        return menuView
    }()
}

extension FunnyVC {
    override func setupUI() {
        super.setupUI()
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.headerReferenceSize = CGSize.zero
//        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)//设置内边距
    }
}


extension FunnyVC {
    override func loadData() {
        baseVM = funnyVM
        funnyVM.requestData {
            self.collectionView.reloadData()
            
            var tempGroups = self.funnyVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            self.loadDataFinished()
        }
    }
}
