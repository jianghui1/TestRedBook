//
//  OUNavAnimation.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit

protocol OUNavAnimationDelegate {
    func didFinishTransition() -> ()
}

class OUNavAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var imageView: UIImageView!
    var origionRect: CGRect = CGRectZero
    var desRect: CGRect = CGRectZero
    var isPush: Bool = false
    var delegate: OUNavAnimationDelegate? = nil
    
    private let transitionContext: UIViewControllerContextTransitioning? = nil
    

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let contentView = transitionContext.containerView()
        contentView?.backgroundColor = UIColor.whiteColor()
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        var imageView: UIImageView? = UIImageView(image: self.imageView.image)
        imageView!.frame = self.isPush ? self.origionRect : self.desRect
        imageView!.backgroundColor = self.imageView.backgroundColor
        contentView?.addSubview((toVc?.view)!)
        toVc?.view.alpha = 0
        
        contentView?.addSubview(imageView!)
        UIView.animateWithDuration(0.2) { 
            toVc?.view.alpha = 1.0
        }
        
        var image: UIImage? = nil
        if !self.isPush {
            image = self.imageView.image?.copy() as? UIImage
            self.imageView.image = nil
        }
        
        UIView.animateWithDuration(0.3, animations: { 
            imageView!.frame = self.isPush ? self.desRect : self.origionRect
        }) { (finished: Bool) in
            if self.delegate != nil {
                self.delegate?.didFinishTransition()
            }
            
            transitionContext .completeTransition(true)
            
            imageView!.removeFromSuperview()
            if !self.isPush {
                self.imageView.image = image
            }
            imageView = nil
        }
    }
    
}
