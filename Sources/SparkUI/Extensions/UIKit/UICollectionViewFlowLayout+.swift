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
    func itemSize(_ itemSize: CGSize) -> UICollectionViewFlowLayout {
        let width = itemSize.width - minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let height = itemSize.height - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
        self.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func item(width: CGFloat, height: CGFloat) -> UICollectionViewFlowLayout {
        let width = width - minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let height = height - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
        self.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func estimatedItemSize(_ estimatedItemSize: CGSize) -> UICollectionViewFlowLayout {
        let width = estimatedItemSize.width - minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let height = estimatedItemSize.height - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
        self.estimatedItemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func estimatedItem(width: CGFloat, height: CGFloat) -> UICollectionViewFlowLayout {
        let width = width - minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let height = height - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
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
