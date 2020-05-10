//
//  SNavigator.swift
//  
//
//  Created by Alex Nagy on 06/05/2020.
//

import Foundation
import UIKit
import SwiftEntryKit

open class SNavigator: NSObject, SNavigatable {
    public var childNavigators: [SNavigatable] = [SNavigatable]()
    public var navigation: UINavigationController = UINavigationController()
    
    open func start() { }
    
    public func didDismiss(_ child: Navigatable?) {
        for (index, navigator) in childNavigators.enumerated() {
            if navigator === child {
                childNavigators.remove(at: index)
                break
            }
        }
    }
    
}

extension SNavigator: Presentable {
    public func present(_ viewControllerToPresent: UIViewController,
                        modalPresentationStyle: UIViewControllerModalPresentationStyle = .sheet(),
                        swipeToDismissStyle: UIViewControllerSwipeToDismissStyle = .enabled,
                        animationType: UIViewControllerAnimationType = .slide,
                        hapticFeedbackType: EKAttributes.NotificationHapticFeedback = .none) {
        SSheet.present(viewControllerToPresent,
                       modalPresentationStyle: modalPresentationStyle,
                       swipeToDismissStyle: swipeToDismissStyle,
                       animationType: animationType,
                       hapticFeedbackType: hapticFeedbackType)
    }
}


extension SNavigator: SHideable {
    public func dismiss(completion: @escaping () -> ()) {
        SSheet.dismiss(completion: completion)
    }
    
    public func dismiss() {
        SSheet.dismiss()
    }
    
    public func pop(animated: Bool) {
        navigation.pop(animated: animated)
    }
    
    public func pop() {
        navigation.pop()
    }
    
    public func popToRoot(animated: Bool) {
        navigation.popToRoot(animated: animated)
    }
    
    public func popToRoot() {
        navigation.popToRoot()
    }
}

extension SNavigator {
    public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let visibleViewController = visibleViewController() {
            visibleViewController.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func dismiss(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let visibleViewController = visibleViewController() {
            visibleViewController.dismiss(animated: flag, completion: completion)
        }
    }
}
