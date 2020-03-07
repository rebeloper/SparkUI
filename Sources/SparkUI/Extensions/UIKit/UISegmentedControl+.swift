//
//  UISegmentedControl+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

extension UISegmentedControl {
    
    @discardableResult
    public func insertSegments(_ segments: [String]) -> UISegmentedControl {
        for i in 0..<segments.count {
            let segment = segments[i]
            insertSegment(withTitle: segment, at: i, animated: false)
        }
        return self
    }
    
    @discardableResult
    public func select(_ index: Int) -> UISegmentedControl {
        selectedSegmentIndex = index
        return self
    }
}

