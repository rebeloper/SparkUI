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
}

extension SNavigator: WebNavigatable {
    public func showWeb(url: String, navigatorActionType: SNavigatorActionType) {
        let controller = SWebViewController_withNavigator(url: url, navigatorActionType: navigatorActionType)
        controller.navigator = self
        switch navigatorActionType {
        case .pushed:
            navigation.push(controller)
        case .presented:
            SSheet.present(navigationController, swipeToDismissStyle: .enabled, withNavigationBar: true)
        }
    }
}


