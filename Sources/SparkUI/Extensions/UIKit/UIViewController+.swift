//
//  UIViewController+.swift
//  
//
//  Created by Alex Nagy on 07/04/2020.
//

import UIKit

extension UIViewController {
    public func hideTabBar(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.3) {

        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        let visible = !hidden
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }

        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)

        // zero duration means no animation
        let duration: TimeInterval = (animated ? duration : 0.0)

        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
        
    }

    public func tabBarIsVisible() -> Bool {
        return (self.tabBarController?.tabBar.frame.origin.y)! < self.view.frame.maxY
    }

}

