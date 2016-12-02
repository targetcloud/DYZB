//
//  PageContentView.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/6.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

//MARK:- 定义代理1
protocol PageContentViewDelegate :class {
    func pageContentView(_ contentView : PageContentView,progress : CGFloat,sourceIndex :Int , targetIndex :Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var childVcs :[UIViewController]
    //需要改成弱引用，否则有循环引用
    fileprivate weak var parentVc : UIViewController?//改成弱引用，那么是可选类型，那么就有?
    
    //MARK:- 定义代理2
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout =  UICollectionViewFlowLayout()
        //布局属性 大小 滚动方向  间距
        layout.itemSize = (self?.bounds.size)!//使用[weak self] in 后: self.bounds.size => (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //自身属性 滚动指示器 弹 分页
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        
        //设置数据源、注册cell类
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        //设置滚动代理
        collectionView.delegate = self
        
        return collectionView
    }()
    
    init(frame: CGRect,childVcs : [UIViewController],parentVc:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc//可选类型赋值给可选类型
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView{
    fileprivate func setupUI(){
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 遵守UICollectionViewDataSource数据源协议
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK:- 遵守UICollectionViewDelegate代理
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //是点击传导过来的，则不处理
        if isForbidScrollDelegate { return }
        
        //滚动处理
        var progress : CGFloat = 0
        var sourceIndex :Int = 0
        var targetIndex :Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
//            print("<left<progress[\(progress)] sourceIndex[\(sourceIndex)] targetIndex[\(targetIndex)]")
        }else{
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex =  Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            //完全划过去
            if startOffsetX - currentOffsetX == scrollViewW {
                sourceIndex = targetIndex
            }
//            print(">right>progress[\(progress)] sourceIndex[\(sourceIndex)] targetIndex[\(targetIndex)]")
        }
        //MARK:- 定义代理3
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:-对外公开的操作FUNC,1、用于homevc作为pagetitleview的代理，再由homevc调用到这里
extension PageContentView{
    func setCurrentIndex(currentIndex : Int){
        isForbidScrollDelegate = true
        let offsetX = CGFloat( currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
