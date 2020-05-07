//
//  SNavigatorCommonProtocols.swift
//  
//
//  Created by Alex Nagy on 07/05/2020.
//

import Foundation

protocol Dismissable_withCompletion: AnyObject {
    func dismiss(completion: @escaping () -> ())
}

protocol Dismissable: AnyObject {
    func dismiss()
}

protocol Popable_Animated: AnyObject {
    func pop(animated: Bool)
}

protocol Popable: AnyObject {
    func pop()
}

protocol PopToRootable_Animated: AnyObject {
    func popToRoot(animated: Bool)
}

protocol PopToRootable: AnyObject {
    func popToRoot()
}

protocol WebNavigatable: AnyObject {
    func pushWeb(url: String)
}

extension SNavigator: Dismissable_withCompletion {
    func dismiss(completion: @escaping () -> ()) {
        SSheet.dismiss(completion: completion)
    }
}

extension SNavigator: Dismissable {
    func dismiss() {
        SSheet.dismiss()
    }
}
