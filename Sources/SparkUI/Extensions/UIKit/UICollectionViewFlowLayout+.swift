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
    func sectionInset(_ sectionInset: UIEdgeInsets) -> UICollectionViewFlowLayout {
        self.sectionInset = sectionInset
        return self
    }
    
    @discardableResult
    func itemSize(_ itemSize: CGSize) -> UICollectionViewFlowLayout {
        self.itemSize = itemSize
        return self
    }
    
    @discardableResult
    func itemSizeWith(_ side: Side, percentage: Percentage, constant: CGFloat, in containerView: UIView) -> UICollectionViewFlowLayout {
        switch side {
        case .width:
            let width = containerView.frame.size.width * percentage.rawValue - minimumInteritemSpacing - sectionInset.left - sectionInset.right
            self.itemSize = CGSize(width: width, height: constant)
        case .height:
            let height = containerView.frame.size.height * percentage.rawValue - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
            self.itemSize = CGSize(width: constant, height: height)
        }
        return self
    }
    
    @discardableResult
    func itemSizeWith(widthPercentage: Percentage, heightPercentage: Percentage, in containerView: UIView) -> UICollectionViewFlowLayout {
        let width = containerView.frame.size.width * widthPercentage.rawValue - minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let height = containerView.frame.size.height * heightPercentage.rawValue - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
        self.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func estimatedItemSize(_ estimatedItemSize: CGSize) -> UICollectionViewFlowLayout {
        self.estimatedItemSize = estimatedItemSize
        return self
    }
    
    @discardableResult
    func flexibleItem(_ side: Side, in containerView: UIView) -> UICollectionViewFlowLayout {
        switch side {
        case .width:
            let height = containerView.frame.size.height - minimumInteritemSpacing - sectionInset.top - sectionInset.bottom
            self.estimatedItemSize = CGSize(width: 1, height: height)
        case .height:
            let width = containerView.frame.size.width - minimumInteritemSpacing - sectionInset.left - sectionInset.right
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
