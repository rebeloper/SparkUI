//
//  SHero.swift
//  
//
//  Created by Alex Nagy on 13/03/2020.
//

import UIKit
import Hero

struct SHero {
    static func show(_ controller: UIViewController, from fromController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        controller.hero.isEnabled = true
        fromController.navigationController?.hero.isEnabled = true
        fromController.navigationController?.hero.navigationAnimationType = navigationAnimationType
        fromController.navigationController?.pushViewController(controller, animated: true)
    }
    
    // call this in viewWillAppear(animated:) to allow SHero navigation alongside regular UINavigation
    static func viewWillAppear(in controller: UIViewController) {
        controller.navigationController?.hero.isEnabled = false
    }
}
