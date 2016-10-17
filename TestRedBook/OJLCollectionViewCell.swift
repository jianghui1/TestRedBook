//
//  OJLCollectionViewCell.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit
import SnapKit
import ImageLoader

class OJLCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let line = UIView()
        line.backgroundColor = UIColor.blackColor()
        line.alpha = 0.2
        contentView.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(0.5)
            make.top.equalTo(label.snp_bottom).offset(8)
        }
        
        iconImageView.layer.cornerRadius = 11
        iconImageView.layer.masksToBounds = true
    }
    
    private var pmodel: Model = Model()
    var model: Model {
        set {
            pmodel = newValue
            imageView.load(NSURL(string: newValue.img)!, placeholder: UIImage(named: "chatListCellHead")) { (url: NSURL, image: UIImage?, error: NSError?, cacheType: CacheType) in
                
                if let image = image {
                    self.pmodel.w = NSNumber(float: NSString(format: "%.2f", (image.size.width)).floatValue)
                    self.pmodel.h = NSNumber(float: NSString(format: "%.2f", (image.size.height)).floatValue)
                }
            }
            
            nameLb.text = newValue.name
            label.text = newValue.des
            iconImageView.load(NSURL(string: newValue.icon)!, placeholder: UIImage(named: "chatListCellHead"), completionHandler: nil)
        }
        get {
            return pmodel
        }
    }

}
