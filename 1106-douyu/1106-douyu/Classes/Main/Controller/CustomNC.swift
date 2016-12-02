//
//  CustomNC.swift
//  1106-douyu
//
//  Created by targetcloud on 2016/11/11.
//  Copyright © 2016年 targetcloud. All rights reserved.
//

import UIKit

class CustomNC: UINavigationController {//NC 是 Navigation Controller 缩写

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        class_copyMethodList(<#T##cls: AnyClass!##AnyClass!#>, <#T##outCount: UnsafeMutablePointer<UInt32>!##UnsafeMutablePointer<UInt32>!#>)
//        class_copyPropertyList(<#T##cls: AnyClass!##AnyClass!#>, <#T##outCount: UnsafeMutablePointer<UInt32>!##UnsafeMutablePointer<UInt32>!#>)
//        class_copyProtocolList(<#T##cls: AnyClass!##AnyClass!#>, <#T##outCount: UnsafeMutablePointer<UInt32>!##UnsafeMutablePointer<UInt32>!#>)
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        /*
         _gestureFlags
         _targets
         _delayedTouches
         _delayedPresses
         _view
         _lastTouchTimestamp
         _state
         _allowedTouchTypes
         _initialTouchType
         _internalActiveTouches
         _forceClassifier
         _requiredPreviewForceState
         _touchForceObservable
         _touchForceObservableAndClassifierObservation
         _forceTargets
         _forcePressCount
         _beganObservable
         _failureRequirements
         _failureDependents
         _delegate
         _allowedPressTypes
         _gestureEnvironment
         */
        
        guard let systemGes = interactivePopGestureRecognizer else { return }
        guard let gesView = systemGes.view else { return }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
//        print(targets)
        //Optional(
        //         [(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7faa0ff11710>)]
        //)
        guard let targetObjc = targets?.first else { return }
        guard let target = targetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))//guard let action = targetObjc.value(forKey: "action") as? Selector else {return} 不能这样写
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        gesView.addGestureRecognizer(panGes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
