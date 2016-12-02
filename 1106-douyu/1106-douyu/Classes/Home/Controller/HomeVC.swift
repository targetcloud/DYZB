//
//  HomeVC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/6.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeVC: UIViewController {

    let titles = ["推荐","手游","娱乐","游戏","趣玩"]
    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        //MARK:- 控制器作为PageTitleViewDelegate代理
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavBarH - kTitleViewH - kTabBarH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendVC())
        childVcs.append(HandsVC())
        childVcs.append(AmuseVC())
        childVcs.append(GameVC())
        childVcs.append(FunnyVC())
//        for _ in 0..<(self?.titles.count)! {
//            let vc = UIViewController()
//            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
//            childVcs.append(vc)
//        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension HomeVC{
    fileprivate func setupUI(){
        //不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavBar(){
        navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "homeLogoIcon")
        let size=CGSize(width: 40, height: 40)
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highlightedImage: "searchBtnIconHL", size: size)
        let qrItem = UIBarButtonItem(imageName: "scanIcon", highlightedImage: "scanIconHL", size: size)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highlightedImage: "viewHistoryIconHL", size: size)
        let MessageItem = UIBarButtonItem(imageName: "siteMessageHome", highlightedImage: "siteMessageHomeH", size: size)
        navigationItem.rightBarButtonItems = [searchItem,qrItem,historyItem,MessageItem]
    }
}

//MARK:- PageTitleViewDelegate代理实现
extension HomeVC : PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- PageContentViewDelegate代理实现
extension HomeVC : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
