//
//  PWLayout.swift
//  瀑布流Demo
//
//  Created by Tony_Zhao on 3/30/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit

protocol PWLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}


class PWLayout: UICollectionViewLayout{
    
    var cellPadding: CGFloat = 0
    var delegate:PWLayoutDelegate!
    
    var numberOfColumn = 1
    
    var contentHeight: CGFloat = 0
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var width: CGFloat{
        get{
            let insets = collectionView!.contentInset
            return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
        }
    }
    
    //构造布局用的数据
    override func prepareLayout() {

        if cache.isEmpty{
            
            let columnWidth = width / CGFloat(numberOfColumn)
            
            var xOffsets = [CGFloat]()
            
            for column in 0..<numberOfColumn{
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            var yOffsets = [CGFloat](count: numberOfColumn, repeatedValue: 0)
            
            var column = 0
            for item in 0..<collectionView!.numberOfItemsInSection(0){
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let width = columnWidth - (2 * cellPadding)
                let itemHeight = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
               
                let height = itemHeight
                
                let frame = CGRectMake(xOffsets[column], yOffsets[column], width, height)
                
                let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
                
                let  attr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attr.frame = frame
                cache.append(attr)
                
                contentHeight = max(contentHeight,CGRectGetMaxY(frame))
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumn - 1) ? 0: ++column
                
            }
            
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(width, contentHeight)
    }
}