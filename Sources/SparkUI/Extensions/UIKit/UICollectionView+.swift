//
//  UICollectionView+.swift
//  
//
//  Created by Alex Nagy on 17/03/2020.
//

import UIKit

extension UICollectionView {
    public func scrollToLastItem(at scrollPosition: UICollectionView.ScrollPosition, adjustment: CGFloat = 0.0, withDuration duration: TimeInterval = 0.5) {
        let lastSection = self.numberOfSections - 1
        let lastRowInLastSection = self.numberOfItems(inSection: lastSection)
        if lastSection > 0, lastRowInLastSection > 1 {
            let indexPath = IndexPath(row: lastRowInLastSection - 1, section: lastSection)
            self.self.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
            UIView.animate(withDuration: duration) {
                switch scrollPosition {
                case .top, .bottom, .centeredVertically:
                    self.contentOffset.y += adjustment
                case .left, .right, .centeredHorizontally:
                    self.contentOffset.x += adjustment
                default:
                    print("Inavlid scrollPosition: \(scrollPosition)")
                }
            }
        }
    }
}
