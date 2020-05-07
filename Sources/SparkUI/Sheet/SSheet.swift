//
//  SSheet.swift
//  
//
//  Created by Alex Nagy on 06/05/2020.
//

import SwiftEntryKit
import ReactiveKit
import UIKit

public struct SSheetState {
    public static let isPresented = Property(false)
}

public struct SSheetAttributes {
    public static var shared: EKAttributes = {
        var attributes: EKAttributes = .bottomToast
        
        attributes.windowLevel = .normal
        
        attributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.5)))
        attributes.displayDuration = .infinity
        
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.safeArea = .overridden
        attributes.entryInteraction = .delayExit(by: Int.max)
        attributes.screenInteraction = .absorbTouches
        
        attributes.lifecycleEvents.didAppear = {
            SSheetState.isPresented.value = true
        }

        attributes.lifecycleEvents.didDisappear = {
            SSheetState.isPresented.value = false
        }
        
        return attributes
    }()
}

public struct SSheet {
    public static func present(_ viewControllerToPresent: UIViewController,
                 modalPresentationStyle: UIViewControllerModalPresentationStyle = .sheet(),
                 swipeToDismissStyle: UIViewControllerSwipeToDismissStyle = .enabled,
                 animationType: UIViewControllerAnimationType = .slide,
                 hapticFeedbackType: EKAttributes.NotificationHapticFeedback = .none) {
        
        SSheetAttributes.shared.hapticFeedbackType = hapticFeedbackType
        
        switch modalPresentationStyle {
        case .fill:
            viewControllerToPresent.view.setCorner(0, maskedCorners: CACornerMask_topCorners)
            SSheetAttributes.shared.positionConstraints.size = .screen
        case .sheet(let topPadding, let topCornerRadius):
            viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
            SSheetAttributes.shared.positionConstraints.size = .init(
                width: .fill,
                height: .constant(value: UIScreen.main.bounds.height - topPadding)
            )
        case .intrinsic(let topCornerRadius):
            viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
            SSheetAttributes.shared.positionConstraints.size = .init(
                width: .constant(value: viewControllerToPresent.view.frame.width),
                height: .intrinsic
            )
        case .constant(let height, let topCornerRadius):
            viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
            SSheetAttributes.shared.positionConstraints.size = .init(
                width: .constant(value: viewControllerToPresent.view.frame.width),
                height: .constant(value: height)
            )
        }
        
        switch swipeToDismissStyle {
        case .disabled:
            SSheetAttributes.shared.scroll = .disabled
        case .enabled:
            SSheetAttributes.shared.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        case .sticky:
            SSheetAttributes.shared.scroll = .enabled(swipeable: false, pullbackAnimation: .easeOut)
        }
        
        switch animationType {
        case .none:
            SSheetAttributes.shared.entranceAnimation = .none
            SSheetAttributes.shared.exitAnimation = .none
        case .slide:
            SSheetAttributes.shared.entranceAnimation = .translation
            SSheetAttributes.shared.exitAnimation = .translation
        case .fade(let duration):
            SSheetAttributes.shared.entranceAnimation = .init(fade: .init(from: 0.0, to: 1.0, duration: duration))
            SSheetAttributes.shared.exitAnimation = .init(fade: .init(from: 1.0, to: 0.0, duration: duration))
        }
        
        SwiftEntryKit.display(entry: viewControllerToPresent, using: SSheetAttributes.shared, presentInsideKeyWindow: true)
    }
    
    public static func dismiss(completion: @escaping () -> () = {}) {
        SwiftEntryKit.dismiss {
            completion()
        }
    }
}

