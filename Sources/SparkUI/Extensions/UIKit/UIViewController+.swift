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

// MARK: - SwiftEntryKit present modal

import SwiftEntryKit

extension UIViewController {
    public func present(_ viewControllerToPresent: UIViewController,
                 modalPresentationStyle: UIViewControllerModalPresentationStyle = .sheet(),
                 swipeToDismissStyle: UIViewControllerSwipeToDismissStyle = .enabled,
                 animationType: UIViewControllerAnimationType = .slide,
                 attributes: EKAttributes = .bottomToast) {
        
        var attributes = attributes
        attributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.7)))
        attributes.displayDuration = .infinity
        
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.safeArea = .overridden
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .forward
        
        switch modalPresentationStyle {
        case .fill:
            viewControllerToPresent.view.setCorner(0, maskedCorners: CACornerMask_topCorners)
            attributes.positionConstraints.size = .screen
        case .sheet(let topPadding, let topCornerRadius):
            viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
            attributes.positionConstraints.size = .init(
                width: .fill,
                height: .constant(value: view.frame.height - topPadding)
            )
        case .intrinsic(let topCornerRadius):
            viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
            attributes.positionConstraints.size = .init(
                width: .constant(value: viewControllerToPresent.view.frame.width),
                height: .intrinsic
            )
        case .constant(let height, let topCornerRadius):
            viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
            attributes.positionConstraints.size = .init(
                width: .constant(value: viewControllerToPresent.view.frame.width),
                height: .constant(value: height)
            )
        }
        
        switch swipeToDismissStyle {
        case .disabled:
            attributes.scroll = .disabled
        case .enabled:
            attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        case .sticky:
            attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .init(duration: 0.5, damping: 5, initialSpringVelocity: 5))
        }
        
        switch animationType {
        case .none:
            attributes.entranceAnimation = .none
            attributes.exitAnimation = .none
        case .slide:
            attributes.entranceAnimation = .translation
            attributes.exitAnimation = .translation
        case .fade(let duration):
            attributes.entranceAnimation = .init(fade: .init(from: 0.0, to: 1.0, duration: duration))
            attributes.exitAnimation = .init(fade: .init(from: 1.0, to: 0.0, duration: duration))
        }
        
        SwiftEntryKit.display(entry: viewControllerToPresent, using: attributes)
    }
    
    public func dismiss(completion: @escaping () -> () = {}) {
        SwiftEntryKit.dismiss {
            completion()
        }
    }
}


