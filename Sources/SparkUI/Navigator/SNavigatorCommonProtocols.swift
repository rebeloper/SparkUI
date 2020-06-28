//
//  SNavigatorCommonProtocols.swift
//  
//
//  Created by Alex Nagy on 07/05/2020.
//

import Foundation
import UIKit

// MARK: -
public protocol WebNavigatable: AnyObject {
    func showWeb(url: String, navigatorActionType: SNavigatorActionType)
    func showWeb(url: String, navigatorActionType: SNavigatorActionType, delegate: UIViewController)
}

extension SNavigator: WebNavigatable {
    public func showWeb(url: String, navigatorActionType: SNavigatorActionType) {
        let controller = SWebViewController_withNavigator(url: url, navigatorActionType: navigatorActionType)
        controller.navigator = self
        switch navigatorActionType {
        case .pushed:
            navigation.push(controller)
        case .presented:
            present(controller, swipeToDismissStyle: .enabled, withNavigationBar: true)
        }
    }
    
    public func showWeb(url: String, navigatorActionType: SNavigatorActionType, delegate: UIViewController) {
        let controller = SWebViewController_withNavigator(url: url, navigatorActionType: navigatorActionType)
        controller.navigator = self
        controller.delegate = delegate as? SWebViewControllerDelegate
        switch navigatorActionType {
        case .pushed:
            navigation.push(controller)
        case .presented:
            present(controller, swipeToDismissStyle: .enabled, withNavigationBar: true)
        }
    }
}


