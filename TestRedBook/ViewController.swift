//
//  ViewController.swift
//  TestRedBook
//
//  Created by ys on 16/8/25.
//  Copyright © 2016年 jzh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, OJLWaterLayoutDelegate {
    
    lazy var modelArray: NSArray = {
        Model.models()
    }()
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "小红书"
        
        let layout = OJLWaterLayout()
        layout.delegate = self
        layout.autoContentSize()
        layout.numberOfCol = 2
        layout.rowPanding = 15
        layout.colPanding = 15
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        collectionView.registerNib(UINib(nibName: "OJLCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: OJLCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! OJLCollectionViewCell
        cell.model = self.modelArray[indexPath.item] as! Model
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = self.modelArray[indexPath.item] as! Model
        let detailVC = DetailViewController(model: model)
        
        let desImageViewRect = CGRect(x: 0.0, y: 60.0 + 64.0, width: model.scaleSize().width, height: model.scaleSize().height)
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! OJLCollectionViewCell
        
        (self.navigationController as! OUNavigationController).pushViewController(detailVC, imageView: cell.imageView, desRect: desImageViewRect, delegate: detailVC)
    }
    

    func waterLayout(waterLayout: UICollectionViewLayout, itemHeight indexPath: NSIndexPath) -> (CGSize, CGFloat) {
        let model: Model = self.modelArray[indexPath.item] as! Model
        return (CGSize(width: CGFloat(model.w.floatValue), height: CGFloat(model.h.floatValue)), 105)
    }
    

}

