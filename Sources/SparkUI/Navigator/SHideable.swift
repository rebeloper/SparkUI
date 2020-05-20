//
//  SHideable.swift
//  
//
//  Created by Alex Nagy on 07/05/2020.
//

import Foundation
import UIKit
import SwiftEntryKit

public protocol Presentable: AnyObject {
    func present(_ viewControllerToPresent: UIViewController,
                 modalPresentationStyle: UIViewControllerModalPresentationStyle,
                 swipeToDismissStyle: UIViewControllerSwipeToDismissStyle,
                 animationType: UIViewControllerAnimationType,
                 hapticFeedbackType: EKAttributes.NotificationHapticFeedback,
                 withNavigationBar: Bool)
}

public protocol Dismissable_withCompletion: AnyObject {
    func dismiss(completion: @escaping () -> ())
}

public protocol Dismissable: AnyObject {
    func dismiss()
}

public protocol Popable_Animated: AnyObject {
    func pop(animated: Bool)
}

public protocol Popable: AnyObject {
    func pop()
}

public protocol PopToRootable_Animated: AnyObject {
    func popToRoot(animated: Bool)
}

public protocol PopToRootable: AnyObject {
    func popToRoot()
}

public protocol Modal_Presentable: AnyObject {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

public protocol Modal_Dismissable: AnyObject {
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}
