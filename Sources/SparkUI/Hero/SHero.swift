//
//  SHero.swift
//  
//
//  Created by Alex Nagy on 13/03/2020.
//

import UIKit
import Hero

public struct SHero {
    static func show(_ viewController: UIViewController, from fromController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        fromController.navigationController?.hero.isEnabled = true
        fromController.navigationController?.hero.navigationAnimationType = navigationAnimationType
        fromController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // call this in viewWillDisappear(animated:) in the destination view controller when you leave the SHero enabled view controller and you want to disable SHero
    // already added in SViewController
    static func disable(in viewController: UIViewController) {
        viewController.navigationController?.hero.isEnabled = false
    }
    
    // call this in viewWillAppear(animated:) if you're coming from a view controller that has SHero disabled into a view controller that needs SHero enabled
    // needed if you can navigate back to this view controller with the navigationItem back button
    // already added in SViewController
    static func enable(in viewController: UIViewController) {
        viewController.hero.isEnabled = true
        viewController.navigationController?.hero.isEnabled = true
    }
}
