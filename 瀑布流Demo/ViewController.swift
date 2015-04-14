//
//  ViewController.swift
//  瀑布流Demo
//
//  Created by Tony_Zhao on 3/30/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var colors: [UIColor] {
        get {
            var colors = [UIColor]()
            let palette = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor(), UIColor.purpleColor(), UIColor.yellowColor()]
            var paletteIndex = 0
            for i in 0..<20 {
                colors.append(palette[paletteIndex])
                paletteIndex = paletteIndex == (palette.count - 1) ? 0 : ++paletteIndex
            }
            return colors
        }
    }

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        let layout = collectionViewLayout as PWLayout
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumn = 2
        
    }
}

extension ViewController{
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        
        cell.contentView.backgroundColor = colors[indexPath.item]
        return cell
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
}

extension ViewController: PWLayoutDelegate{
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let randomV = arc4random_uniform(4) + 1
        
        return CGFloat(randomV * 100)
    }
    
    
}

