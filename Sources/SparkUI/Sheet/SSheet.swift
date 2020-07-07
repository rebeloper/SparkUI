//
//  SSheet.swift
//  
//
//  Created by Alex Nagy on 06/05/2020.
//

import SwiftEntryKit
import UIKit

public struct SSheetState {
    public static let isPresented = Bucket(false)
}

public enum SSheetType {
    case bottom, top
}

public struct SSheetAttributes {
    public static var bottomToast: EKAttributes = {
        var attributes: EKAttributes = .bottomToast
        
        attributes.displayDuration = .infinity
        
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.safeArea = .overridden
        attributes.entryInteraction = .delayExit(by: TimeInterval(Int.max))
        attributes.screenInteraction = .absorbTouches
        
        attributes.lifecycleEvents.didAppear = {
            SSheetState.isPresented.value = true
        }

        attributes.lifecycleEvents.didDisappear = {
            SSheetState.isPresented.value = false
        }
        
        return attributes
    }()
    
    public static var topToast: EKAttributes = {
        var attributes: EKAttributes = .topToast
        
        attributes.displayDuration = .infinity
        
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.safeArea = .overridden
        attributes.entryInteraction = .delayExit(by: TimeInterval(Int.max))
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
                 hapticFeedbackType: EKAttributes.NotificationHapticFeedback = .none,
                 backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.5),
                 sheetType: SSheetType = .bottom) {
        
        switch sheetType {
        case .bottom:
            SSheetAttributes.bottomToast.hapticFeedbackType = hapticFeedbackType
            SSheetAttributes.bottomToast.screenBackground = .color(color: EKColor(backgroundColor))
            
            switch modalPresentationStyle {
            case .fill:
                viewControllerToPresent.view.setCorner(0, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.bottomToast.positionConstraints.size = .screen
            case .sheet(let topPadding, let topCornerRadius):
                viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.bottomToast.positionConstraints.size = .init(
                    width: .fill,
                    height: .constant(value: UIScreen.main.bounds.height - topPadding)
                )
            case .intrinsic(let topCornerRadius):
                viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.bottomToast.positionConstraints.size = .init(
                    width: .constant(value: viewControllerToPresent.view.frame.width),
                    height: .intrinsic
                )
            case .constant(let height, let topCornerRadius):
                viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.bottomToast.positionConstraints.size = .init(
                    width: .constant(value: viewControllerToPresent.view.frame.width),
                    height: .constant(value: height)
                )
            }
            
            switch swipeToDismissStyle {
            case .disabled:
                SSheetAttributes.bottomToast.scroll = .disabled
            case .enabled:
                SSheetAttributes.bottomToast.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            case .sticky:
                SSheetAttributes.bottomToast.scroll = .enabled(swipeable: false, pullbackAnimation: .easeOut)
            }
            
            switch animationType {
            case .none:
                SSheetAttributes.bottomToast.entranceAnimation = .none
                SSheetAttributes.bottomToast.exitAnimation = .none
            case .slide:
                SSheetAttributes.bottomToast.entranceAnimation = .translation
                SSheetAttributes.bottomToast.exitAnimation = .translation
            case .fade(let duration):
                SSheetAttributes.bottomToast.entranceAnimation = .init(fade: .init(from: 0.0, to: 1.0, duration: duration))
                SSheetAttributes.bottomToast.exitAnimation = .init(fade: .init(from: 1.0, to: 0.0, duration: duration))
            }
            
            SwiftEntryKit.display(entry: viewControllerToPresent, using: SSheetAttributes.bottomToast, presentInsideKeyWindow: true)
            
        case .top:
            SSheetAttributes.topToast.hapticFeedbackType = hapticFeedbackType
            SSheetAttributes.topToast.screenBackground = .color(color: EKColor(backgroundColor))
            
            switch modalPresentationStyle {
            case .fill:
                viewControllerToPresent.view.setCorner(0, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.topToast.positionConstraints.size = .screen
            case .sheet(let topPadding, let topCornerRadius):
                viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.topToast.positionConstraints.size = .init(
                    width: .fill,
                    height: .constant(value: UIScreen.main.bounds.height - topPadding)
                )
            case .intrinsic(let topCornerRadius):
                viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.topToast.positionConstraints.size = .init(
                    width: .constant(value: viewControllerToPresent.view.frame.width),
                    height: .intrinsic
                )
            case .constant(let height, let topCornerRadius):
                viewControllerToPresent.view.setCorner(topCornerRadius, maskedCorners: CACornerMask_topCorners)
                SSheetAttributes.topToast.positionConstraints.size = .init(
                    width: .constant(value: viewControllerToPresent.view.frame.width),
                    height: .constant(value: height)
                )
            }
            
            switch swipeToDismissStyle {
            case .disabled:
                SSheetAttributes.topToast.scroll = .disabled
            case .enabled:
                SSheetAttributes.topToast.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            case .sticky:
                SSheetAttributes.topToast.scroll = .enabled(swipeable: false, pullbackAnimation: .easeOut)
            }
            
            switch animationType {
            case .none:
                SSheetAttributes.topToast.entranceAnimation = .none
                SSheetAttributes.topToast.exitAnimation = .none
            case .slide:
                SSheetAttributes.topToast.entranceAnimation = .translation
                SSheetAttributes.topToast.exitAnimation = .translation
            case .fade(let duration):
                SSheetAttributes.topToast.entranceAnimation = .init(fade: .init(from: 0.0, to: 1.0, duration: duration))
                SSheetAttributes.topToast.exitAnimation = .init(fade: .init(from: 1.0, to: 0.0, duration: duration))
            }
            
            SwiftEntryKit.display(entry: viewControllerToPresent, using: SSheetAttributes.topToast, presentInsideKeyWindow: true)
        }
        
        
    }
    
    public static func dismiss(completion: @escaping () -> () = {}) {
        SwiftEntryKit.dismiss {
            completion()
        }
    }
}

