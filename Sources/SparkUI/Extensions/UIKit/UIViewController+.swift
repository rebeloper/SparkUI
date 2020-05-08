//
//  UIViewController+.swift
//  
//
//  Created by Alex Nagy on 07/04/2020.
//

import UIKit

extension UIViewController {
    
    public func hideTabBar(_ hidden: Bool = true, animated: Bool = true, duration: TimeInterval = 0.3) {

        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        //* make sure that your view controller's view is not pinned to the safe area at the bottom
        
        let visible = !hidden
        // bail if the current state matches the desired state
        if (isTabBarVisible() == visible) { return }

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

    public func isTabBarVisible() -> Bool {
        return (self.tabBarController?.tabBar.frame.origin.y)! < self.view.frame.maxY
    }
    
    public func showTabBar(_ show: Bool = true, animated: Bool = true, duration: TimeInterval = 0.3) {
        hideTabBar(!show, animated: animated, duration: duration)
    }

}

extension UIViewController {
    public func setTabBarItem(title: String?, selectedImageSystemImageName: String, unselectedImageSystemImageName: String, selectedColor: UIColor, unSelectedColor: UIColor) {
        self.title = title
        tabBarItem.image = UIImage(systemName: unselectedImageSystemImageName)!
            .withTintColor(unSelectedColor, renderingMode: .alwaysTemplate)
            .withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage(systemName: selectedImageSystemImageName)!
            .withTintColor(selectedColor, renderingMode: .alwaysTemplate)
            .withRenderingMode(.alwaysOriginal)
    }
}

extension UIViewController {
    public func showSheet(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let visibleViewController = visibleViewController() {
            visibleViewController.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func dismissSheet(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let visibleViewController = visibleViewController() {
            visibleViewController.dismiss(animated: flag, completion: completion)
        }
    }
}

