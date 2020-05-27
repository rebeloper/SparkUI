//
//  UINavigationController+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit
import Hero

public enum STransitionSubtype {
    case toTop, toBottom, toLeft, toRight
}

public extension UINavigationController {
    
    /// Hides the navigation item background. Does show the navigation items
    func setNavigationItemBackground(hidden: Bool) {
        if hidden {
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
            self.view.backgroundColor = UIColor.clear
        } else {
            self.navigationBar.isTranslucent = false
            self.view.backgroundColor = UIColor.systemWhite
        }
        
    }
    
    func execute(_ transitionType: CATransitionType, _ controller: UIViewController, _ from: CATransitionSubtype, duration: CFTimeInterval = 0.3, timingFunctionName: CAMediaTimingFunctionName = .default) {
        var subtype = from
        switch from {
        case .fromTop:
            subtype = .fromBottom
        case .fromBottom:
            subtype = .fromTop
        case .fromLeft:
            subtype = .fromLeft
        case .fromRight:
            subtype = .fromRight
        default:
            subtype = from
        }
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        view.window!.layer.add(transition, forKey: kCATransition)
        pushViewController(controller, animated: false)
    }
    
    func pop(_ to: STransitionSubtype, _ transitionType: CATransitionType = .push, duration: CFTimeInterval = 0.3, timingFunctionName: CAMediaTimingFunctionName = .default) {
        var subtype: CATransitionSubtype = .fromLeft
        switch to {
        case .toTop:
            subtype = .fromTop
        case .toBottom:
            subtype = .fromBottom
        case .toLeft:
            subtype = .fromRight
        case .toRight:
            subtype = .fromLeft
        }
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
    }
    
    func popToRootViewController(_ from: CATransitionSubtype, _ transitionType: CATransitionType = .push, duration: CFTimeInterval = 0.3, timingFunctionName: CAMediaTimingFunctionName = .linear) {
        var subtype = from
        switch from {
        case .fromTop:
            subtype = .fromBottom
        case .fromBottom:
            subtype = .fromTop
        case .fromLeft:
            subtype = .fromRight
        case .fromRight:
            subtype = .fromLeft
        default:
            subtype = from
        }
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        view.window!.layer.add(transition, forKey: kCATransition)
        popToRootViewController(animated: false)
    }
    
}

public extension UINavigationController {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }
    
    func display(_ viewController: UIViewController) {
        pushViewController(viewController, animated: false)
    }
    
    func pop(animated: Bool = true) {
        popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        popToRootViewController(animated: animated)
    }
    
    func show(_ viewController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        viewController.hero.isEnabled = true
        hero.isEnabled = true
        hero.navigationAnimationType = navigationAnimationType
        pushViewController(viewController, animated: true)
    }
}



