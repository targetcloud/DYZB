//
//  ShowRoomVC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/11.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class ShowRoomVC: UIViewController {
    var maskImageView : UIImageView?
    var anchor: AnchorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ShowRoomVC{
    fileprivate func setupUI() {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imageView.bounds
        imageView.addSubview(effectView)
        guard let icon_URL = URL(string: (anchor?.vertical_src)!) else { return }
        imageView.kf.setImage(with: icon_URL)
        self.maskImageView = imageView
        view.addSubview(maskImageView!)
    }
}
