//
//  Model.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit

class Model: NSObject {
    
    var h: NSNumber!
    var w: NSNumber!
    var img: String!
    var des: String!
    var name: String!
    var icon: String!
    
    static func models() -> Array<Model> {
        var array: Array<Model> = Array()
        
        let dicArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("1", ofType: "plist")!)
        for dic in dicArray! {
            let m: Model = Model()
            m.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
            array.append(m)
        }
        
        return array
    }
    
    func scaleSize() -> CGSize {
        let width = Double(UIScreen.mainScreen().bounds.size.width)
        let scale = width / self.w.doubleValue
        let height = self.h.doubleValue * scale
        return CGSize(width: width, height: height)
    }

}
