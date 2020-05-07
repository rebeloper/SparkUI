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

public protocol WebNavigatable: AnyObject {
    func pushWeb(url: String)
}

extension SNavigator: Dismissable_withCompletion {
    public func dismiss(completion: @escaping () -> ()) {
        SSheet.dismiss(completion: completion)
    }
}

extension SNavigator: Dismissable {
    public func dismiss() {
        SSheet.dismiss()
    }
}
