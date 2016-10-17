//
//  OJLWaterLayout.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit

protocol OJLWaterLayoutDelegate: NSObjectProtocol {
    func waterLayout(waterLayout: UICollectionViewLayout, itemHeight indexPath: NSIndexPath) -> (CGSize, CGFloat)
}

class OJLWaterLayout: UICollectionViewLayout {
    
    // 代理
    var delegate: OJLWaterLayoutDelegate?
    // 每行之间的间距
    var rowPanding: CGFloat = 10
    // 每列之间的间距
    var colPanding: CGFloat = 10
    // 列数
    var numberOfCol: Int = 3
    // contentSize
    var contentSize: CGSize = CGSizeZero
    // 自动配置contentSize
    var sectionInset: UIEdgeInsets = UIEdgeInsetsZero
    func autoContentSize() -> () {
        isAutocontentSize = true
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK : 私有
    lazy var attrArray: [UICollectionViewLayoutAttributes] = {
        Array()
    }()
    lazy var lastHeightForColArray: NSMutableArray = {
        NSMutableArray()
    }()
    var isAutocontentSize: Bool = false
    
    
    // MARK - 布局方法
    override func prepareLayout() {
        super.prepareLayout()
        
        lastHeightForColArray.removeAllObjects()
        
        
        for _ in 0 ..< numberOfCol {
            self.lastHeightForColArray.addObject((self.sectionInset.top))
        }
        
        let count = collectionView?.numberOfItemsInSection(0)
        
        if let count = count {
            for i in 0..<count {
                let indexPath = NSIndexPath(forItem: i, inSection: 0)
                let attr = self.layoutAttributesForItemAtIndexPath(indexPath)
                self.attrArray.append(attr!)
            }
            
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let width = ((self.collectionView?.frame.size.width)! - sectionInset.left - sectionInset.right - CGFloat(numberOfCol - 1) * CGFloat(colPanding)) / CGFloat(numberOfCol)
        var height: CGFloat = 0.0
        
        if delegate != nil {
            //            if self.delegate!.respondsToSelector(#selector(OJLWaterLayoutDelegate.OJLWaterLayout(_:itemHeight:))) {
            let (size, h) = self.delegate!.waterLayout(self, itemHeight: indexPath)
            let scale = size.width / width
            height = size.height / scale + h
            //            }
        }
        
        var minY = self.lastHeightForColArray.count != 0 ? (self.lastHeightForColArray.firstObject?.floatValue) : Float(sectionInset.top)
        var currentCol = 0
        for i in 1..<self.lastHeightForColArray.count {
            if minY > self.lastHeightForColArray[i].floatValue {
                minY = self.lastHeightForColArray[i].floatValue
                currentCol = i
            }
        }
        
        let x = sectionInset.left + (width + CGFloat(colPanding)) * CGFloat(currentCol)
        let y = minY! + Float(rowPanding)
        
        attr.frame = CGRect(x: x, y: CGFloat(y), width: width, height: height)
        self.lastHeightForColArray[currentCol] = (CGRectGetMaxY(attr.frame))
        if self.isAutocontentSize {
            var max = self.lastHeightForColArray.firstObject?.floatValue
            for i in 1..<self.lastHeightForColArray.count {
                if max < self.lastHeightForColArray[i].floatValue {
                    max = self.lastHeightForColArray[i].floatValue
                }
            }
            
            self.contentSize = CGSize(width: (self.collectionView?.bounds.size.width)!, height: CGFloat(max!) + sectionInset.bottom)
        }
        return attr;
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrArray
    }
    
    override func collectionViewContentSize() -> CGSize {
        return self.contentSize
    }
    
}

