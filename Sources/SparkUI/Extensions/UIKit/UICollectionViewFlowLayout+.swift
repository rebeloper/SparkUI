//
//  UICollectionViewFlowLayout+.swift
//  
//
//  Created by Alex Nagy on 30/06/2020.
//

import UIKit

public extension UICollectionViewFlowLayout {
    
    @discardableResult
    func scrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) -> UICollectionViewFlowLayout {
        self.scrollDirection = scrollDirection
        return self
    }
    
    @discardableResult
    func minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> UICollectionViewFlowLayout {
        self.minimumLineSpacing = minimumLineSpacing
        return self
    }
    
    @discardableResult
    func minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> UICollectionViewFlowLayout {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
    @discardableResult
    func sectionInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UICollectionViewFlowLayout {
        self.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func item(width: CGFloat, height: CGFloat) -> UICollectionViewFlowLayout {
        self.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func itemSizeWith(_ side: Side, percentage: Percentage, constant: CGFloat, containerSize: CGSize) -> UICollectionViewFlowLayout {
        switch side {
        case .width:
            let width = containerSize.width * percentage.rawValue - minimumInteritemSpacing - sectionInset.left - sectionInset.right
            self.itemSize = CGSize(width: width, height: constant)
        case .height:
            let height = containerSize.height * percentage.rawValue - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
            self.itemSize = CGSize(width: constant, height: height)
        }
        return self
    }
    
    @discardableResult
    func itemSizeWith(widthPercentage: Percentage, heightPercentage: Percentage, containerSize: CGSize) -> UICollectionViewFlowLayout {
        let width = containerSize.width * widthPercentage.rawValue - minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let height = containerSize.height * heightPercentage.rawValue - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
        self.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func estimatedItem(width: CGFloat, height: CGFloat) -> UICollectionViewFlowLayout {
        self.estimatedItemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func flexibleItem(_ side: Side, fixedLength: CGFloat) -> UICollectionViewFlowLayout {
        switch side {
        case .width:
            let height = fixedLength - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
            self.estimatedItemSize = CGSize(width: 1, height: height)
        case .height:
            let width = fixedLength - minimumInteritemSpacing - sectionInset.left - sectionInset.right
            self.estimatedItemSize = CGSize(width: width, height: 1)
        }
        return self
    }
    
    @discardableResult
    func flexibleItem() -> UICollectionViewFlowLayout {
        self.estimatedItemSize = CGSize(width: 1, height: 1)
        return self
    }
    
    @discardableResult
    func headerReferenceSize(_ headerReferenceSize: CGSize) -> UICollectionViewFlowLayout {
        self.headerReferenceSize = headerReferenceSize
        return self
    }
    
    @discardableResult
    func footerReferenceSize(_ footerReferenceSize: CGSize) -> UICollectionViewFlowLayout {
        self.footerReferenceSize = footerReferenceSize
        return self
    }
    
    @discardableResult
    func sectionHeadersPinToVisibleBounds(_ sectionHeadersPinToVisibleBounds: Bool) -> UICollectionViewFlowLayout {
        self.sectionHeadersPinToVisibleBounds = sectionHeadersPinToVisibleBounds
        return self
    }
    
    @discardableResult
    func sectionFootersPinToVisibleBounds(_ sectionFootersPinToVisibleBounds: Bool) -> UICollectionViewFlowLayout {
        self.sectionFootersPinToVisibleBounds = sectionFootersPinToVisibleBounds
        return self
    }
    
}
