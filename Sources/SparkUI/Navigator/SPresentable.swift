//
//  SPresentable.swift
//  
//
//  Created by Alex Nagy on 09/06/2020.
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
                 backgroundColor: UIColor,
                 sheetType: SSheetType,
                 withNavigationBar: Bool)
}
