//
//  OUNavigationController.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit

class OUNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private var imageView: UIImageView!
    private var origionRect: CGRect = CGRectZero
    private var desRect: CGRect = CGRectZero
    private var isPush: Bool = false
    private var animationDelegate: OUNavAnimationDelegate? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func pushViewController(viewController: UIViewController, imageView: UIImageView, desRect: CGRect, delegate: OUNavAnimationDelegate) {
        self.delegate = self
        self.imageView = imageView
        self.origionRect = imageView.convertRect(imageView.frame, toView: self.view)
        self.desRect = desRect
        self.isPush = true
        self.animationDelegate = delegate
        super.pushViewController(viewController, animated: true)
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        self.isPush = false
        return super.popViewControllerAnimated(animated)
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation: OUNavAnimation = OUNavAnimation()
        animation.imageView = self.imageView
        animation.origionRect = self.origionRect
        animation.desRect = self.desRect
        animation.isPush = self.isPush
        animation.delegate = self.animationDelegate
        
        if (!self.isPush && self.delegate != nil) {
            self.delegate = nil
        }
        return animation
    }

}
