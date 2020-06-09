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
                        hapticFeedbackType: EKAttributes.NotificationHapticFeedback = .none,
                        backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.5),
                        withNavigationBar: Bool = false) {
        if withNavigationBar {
            let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
            SSheet.present(navigationController,
                           modalPresentationStyle: modalPresentationStyle,
                           swipeToDismissStyle: swipeToDismissStyle,
                           animationType: animationType,
                           hapticFeedbackType: hapticFeedbackType,
                           backgroundColor: backgroundColor)
        } else {
            SSheet.present(viewControllerToPresent,
                           modalPresentationStyle: modalPresentationStyle,
                           swipeToDismissStyle: swipeToDismissStyle,
                           animationType: animationType,
                           hapticFeedbackType: hapticFeedbackType,
                           backgroundColor: backgroundColor)
        }
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

extension SNavigator: ModalNavigatable {
    public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let visibleViewController = visibleViewController() {
            visibleViewController.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let visibleViewController = visibleViewController() {
            visibleViewController.dismiss(animated: flag, completion: completion)
        }
    }
}
