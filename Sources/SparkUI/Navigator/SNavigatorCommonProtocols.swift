//
//  SNavigatorCommonProtocols.swift
//  
//
//  Created by Alex Nagy on 07/05/2020.
//

import Foundation
import UIKit

// MARK: -
public protocol Dismissable_withCompletion: AnyObject {
    func dismiss(completion: @escaping () -> ())
}

extension SNavigator: Dismissable_withCompletion {
    public func dismiss(completion: @escaping () -> ()) {
        SSheet.dismiss(completion: completion)
    }
}

// MARK: -
public protocol Dismissable: AnyObject {
    func dismiss()
}

extension SNavigator: Dismissable {
    public func dismiss() {
        SSheet.dismiss()
    }
}

// MARK: -
public protocol Popable_Animated: AnyObject {
    func pop(animated: Bool)
}

extension SNavigator: Popable_Animated {
    public func pop(animated: Bool) {
        navigation.pop(animated: animated)
    }
}

// MARK: -
public protocol Popable: AnyObject {
    func pop()
}

extension SNavigator: Popable {
    public func pop() {
        navigation.pop()
    }
}

// MARK: -
public protocol PopToRootable_Animated: AnyObject {
    func popToRoot(animated: Bool)
}

extension SNavigator: PopToRootable_Animated {
    public func popToRoot(animated: Bool) {
        navigation.popToRoot(animated: animated)
    }
}

// MARK: -
public protocol PopToRootable: AnyObject {
    func popToRoot()
}

extension SNavigator: PopToRootable {
    public func popToRoot() {
        navigation.popToRoot()
    }
}

// MARK: -
public protocol WebNavigatable: AnyObject {
    func showWeb(url: String, navigatorActionType: SNavigatorActionType)
}

extension SNavigator: WebNavigatable {
    public func showWeb(url: String, navigatorActionType: SNavigatorActionType) {
        let controller = SWebViewController_withNavigator(url: url, navigatorActionType: navigatorActionType)
        controller.navigator = self
        switch navigatorActionType {
        case .pushed:
            navigation.push(controller)
        case .presented:
            let navigationController = UINavigationController(rootViewController: controller)
            SSheet.present(navigationController, swipeToDismissStyle: .enabled)
        }
    }
}

