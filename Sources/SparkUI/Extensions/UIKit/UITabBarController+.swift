//
//  UITabBarController+.swift
//  
//
//  Created by Alex Nagy on 06/05/2020.
//

import UIKit

extension UITabBarController {
    public func adjustTabBarItemsForNoTitle() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}
