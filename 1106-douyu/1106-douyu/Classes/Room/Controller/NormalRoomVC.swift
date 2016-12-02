//
//  NormalRoomVC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/11.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class NormalRoomVC: UIViewController,UIGestureRecognizerDelegate {
    var maskImageView : UIImageView?
    var anchor: AnchorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //注意下面一条语句将系统的手势会屏弊掉,如果没有下面的一条语句拖动边缘是可以返回去的
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension NormalRoomVC{
    fileprivate func setupUI() {
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 240)
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imageView.bounds
        imageView.addSubview(effectView)
        
        guard let icon_URL = URL(string: (anchor?.vertical_src)!) else { return }
        imageView.kf.setImage(with: icon_URL)
        maskImageView = imageView
        view.addSubview(maskImageView!)
    }
}
