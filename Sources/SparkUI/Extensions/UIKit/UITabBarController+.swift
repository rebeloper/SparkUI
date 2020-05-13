//
//  UITabBarController+.swift
//  
//
//  Created by Alex Nagy on 06/05/2020.
//

import UIKit

public extension UITabBarController {
    func adjustTabBarItemsForNoTitle(distance: CGFloat = 4) {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: distance, left: 0, bottom: -distance, right: 0)
        }
    }
}
