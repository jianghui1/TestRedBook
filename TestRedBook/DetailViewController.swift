//
//  DetailViewController.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, OUNavAnimationDelegate {
    
    var avatarImageView: UIImageView!
    var followButton: UIButton!
    var contentImageView: UIImageView!
    var contentLb: UILabel!
    var desImageViewRect: CGRect!
    var nameLb: UILabel!
    var scrollView: UIScrollView!
    
    private var pmodel: Model!
    
    var model: Model {
        set {
            pmodel = newValue
            nameLb.text = newValue.name
            nameLb.sizeToFit()
            
            if let icon = newValue.icon {
                avatarImageView.load(NSURL(string: icon)!)
            }
            
            contentLb.text = newValue.des
            contentLb .layoutIfNeeded()
            
            scrollView.contentSize = CGSize(width: view.bounds.size.width, height: CGRectGetMaxY(contentLb.frame) + 20)
            
//            if let image = newValue.img {
//                contentImageView.load(NSURL(string: image)!)
//            }
        }
        get {
            return pmodel
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
    init(model: Model) {
        super.init(nibName: nil, bundle: nil)
        desImageViewRect = CGRect(x: 0.0, y: 64.0 + 60.0, width: model.scaleSize().width, height: model.scaleSize().height)
        setupMain()
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMain() -> () {
        self.automaticallyAdjustsScrollViewInsets = false
        
        scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1000.0)
        
        avatarImageView = UIImageView(frame: CGRect(x: 10, y: 5 + 64, width: 40, height: 40))
        scrollView.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        
        nameLb = UILabel()
        nameLb.font = UIFont.systemFontOfSize(14)
        nameLb.textColor = UIColor.blackColor()
        scrollView.addSubview(nameLb)
        nameLb.frame = CGRect(x: CGRectGetMaxX(avatarImageView.frame) + 10, y: CGFloat(84), width: 0.0, height: 0.0)
        
        followButton = UIButton(type: UIButtonType.Custom)
        followButton.setTitle("+ 关注", forState: UIControlState.Normal)
        followButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        followButton.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.8)
        followButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        followButton.layer.cornerRadius = 2
        followButton.layer.masksToBounds = true
        scrollView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(DetailViewController.followClick), forControlEvents: UIControlEvents.TouchUpInside)
        followButton.frame = CGRect(x: view.frame.size.width - 70, y: 0.0, width: 60.0, height: 25.0)
        followButton.center = CGPoint(x: followButton.center.x, y: avatarImageView.center.y)
        
        contentImageView = UIImageView()
        scrollView.addSubview(contentImageView)
        contentImageView.frame = self.desImageViewRect
        contentImageView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        contentLb = UILabel()
        contentLb.font = UIFont.systemFontOfSize(12)
        contentLb.textColor = UIColor.blackColor()
        contentLb.numberOfLines = 0
        scrollView.addSubview(contentLb)
        contentLb.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(scrollView.snp_width).offset(-20)
            make.top.equalTo(contentImageView.snp_bottom).offset(15)
        }
    }
    
    func followClick() -> () {
        print("关注")
    }
    
    func didFinishTransition() {
        self.contentImageView.load(NSURL(string: self.pmodel.img)!)
    }

}
