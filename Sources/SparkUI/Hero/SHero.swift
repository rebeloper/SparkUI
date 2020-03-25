//
//  SHero.swift
//  
//
//  Created by Alex Nagy on 13/03/2020.
//

import UIKit
import Hero

public struct SHero {
    public static func show(_ controller: UIViewController, from fromController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        controller.hero.isEnabled = true
        fromController.navigationController?.hero.isEnabled = true
        fromController.navigationController?.hero.navigationAnimationType = navigationAnimationType
        fromController.navigationController?.pushViewController(controller, animated: true)
    }
    
    // call this in viewWillAppear(animated:) in the destination view controller when you leave the SHero enabled view controller and you want to disable SHero
    public static func disable(in controller: UIViewController) {
        controller.navigationController?.hero.isEnabled = false
    }
    
    // call this in viewWillAppear(animated:) if you're coming from a view controller that has SHero disabled into a view controller that needs SHero enabled
    // needed if you can navigate back to this view controller with the navigationItem back button
    // already added in SViewController
    public static func enable(in controller: UIViewController) {
        controller.navigationController?.hero.isEnabled = true
    }
}
