//
//  UIPageControl+.swift
//  
//
//  Created by Alex Nagy on 13/06/2020.
//

import UIKit

public extension UIPageControl {
    
    @discardableResult
    func numberOfPages(_ numberOfPages: Int) -> UIPageControl {
        self.numberOfPages = numberOfPages
        return self
    }
    
    @discardableResult
    func pageIndicatorTintColor(_ pageIndicatorTintColor: UIColor) -> UIPageControl {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        return self
    }
    
    @discardableResult
    func currentPageIndicatorTintColor(_ currentPageIndicatorTintColor: UIColor) -> UIPageControl {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        return self
    }
}
