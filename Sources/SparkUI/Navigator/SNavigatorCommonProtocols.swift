//
//  SNavigatorCommonProtocols.swift
//  
//
//  Created by Alex Nagy on 07/05/2020.
//

import Foundation

public protocol Dismissable_withCompletion: AnyObject {
    func dismiss(completion: @escaping () -> ())
}

extension SNavigator: Dismissable_withCompletion {
    public func dismiss(completion: @escaping () -> ()) {
        SSheet.dismiss(completion: completion)
    }
}


public protocol Dismissable: AnyObject {
    func dismiss()
}

extension SNavigator: Dismissable {
    public func dismiss() {
        SSheet.dismiss()
    }
}


public protocol Popable_Animated: AnyObject {
    func pop(animated: Bool)
}

extension SNavigator: Popable_Animated {
    public func pop(animated: Bool) {
        navigation.pop(animated: animated)
    }
}


public protocol Popable: AnyObject {
    func pop()
}

extension SNavigator: Popable {
    public func pop() {
        navigation.pop()
    }
}


public protocol PopToRootable_Animated: AnyObject {
    func popToRoot(animated: Bool)
}

extension SNavigator: PopToRootable_Animated {
    public func popToRoot(animated: Bool) {
        navigation.popToRoot(animated: animated)
    }
}


public protocol PopToRootable: AnyObject {
    func popToRoot()
}

extension SNavigator: PopToRootable {
    public func popToRoot() {
        navigation.popToRoot()
    }
}



public protocol WebNavigatable: AnyObject {
    func pushWeb(url: String)
}


