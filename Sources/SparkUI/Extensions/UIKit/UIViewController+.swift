//
//  UIViewController+.swift
//  
//
//  Created by Alex Nagy on 07/04/2020.
//

import UIKit
import Hero
import Signals

public extension UIViewController {
    
    func hideTabBar(_ hidden: Bool = true, animated: Bool = true, duration: TimeInterval = 0.3) {

        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        //* make sure that your view controller's view is not pinned to the safe area at the bottom
        
        let visible = !hidden
        // bail if the current state matches the desired state
        if (isTabBarVisible() == visible) { return }

        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)

        // zero duration means no animation
        let duration: TimeInterval = (animated ? duration : 0.0)

        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
        
    }

    func isTabBarVisible() -> Bool {
        return (self.tabBarController?.tabBar.frame.origin.y)! < self.view.frame.maxY
    }
    
    func showTabBar(_ show: Bool = true, animated: Bool = true, duration: TimeInterval = 0.3) {
        hideTabBar(!show, animated: animated, duration: duration)
    }

}

public extension UIViewController {
    
    func setTabBarItem(selectedImageName: String, unselectedImageName: String, selectedColor: UIColor, unSelectedColor: UIColor, tag: TabBarTag? = nil, title: String? = nil, tabBarItemTitle: String? = nil) {
        
        self.title = title
        
        tabBarItem = UITabBarItem(
            title: tabBarItemTitle,
            image: UIImage(named: unselectedImageName)?
                .withTintColor(unSelectedColor, renderingMode: .alwaysTemplate)
                .withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: selectedImageName)?
                .withTintColor(selectedColor, renderingMode: .alwaysTemplate)
                .withRenderingMode(.alwaysTemplate)
        )
        if let tag = tag {
            tabBarItem.tag = tag.rawValue
        }
        
    }
    
    func setTabBarItem(selectedImageName: String, unselectedImageName: String, tag: TabBarTag? = nil, title: String? = nil, tabBarItemTitle: String? = nil) {
        
        self.title = title
        
        tabBarItem = UITabBarItem(
            title: tabBarItemTitle,
            image: UIImage(named: unselectedImageName)?
                .withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: selectedImageName)?
                .withRenderingMode(.alwaysOriginal)
        )
        if let tag = tag {
            tabBarItem.tag = tag.rawValue
        }
        
    }
    
    func setTabBarItem(selectedImageSystemImageName: String, unselectedImageSystemImageName: String, selectedColor: UIColor, unSelectedColor: UIColor, tag: TabBarTag? = nil, title: String? = nil, tabBarItemTitle: String? = nil) {
        
        self.title = title
        
        tabBarItem = UITabBarItem(
            title: tabBarItemTitle,
            image: UIImage(systemName: unselectedImageSystemImageName)?
                .withTintColor(unSelectedColor, renderingMode: .alwaysTemplate),
            selectedImage: UIImage(systemName: selectedImageSystemImageName)?
                .withTintColor(selectedColor, renderingMode: .alwaysTemplate)
        )
        if let tag = tag {
            tabBarItem.tag = tag.rawValue
        }
        
    }
    
    func setTitleOnly(_ title: String?) {
        let currentTabBarItemTitle = tabBarItem.title
        self.title = title
        tabBarItem.title = currentTabBarItemTitle
    }
    
}

public extension UIViewController {
    func setAsRoot(for navigator: Navigator, withParentNavigator parentNavigator: Navigator?) {
        navigator.navigation.display(self)
        navigator.present(navigator.navigation)
        SheetState.isPresented.subscribe(with: self) { (isPresented) in
            if !isPresented {
                parentNavigator?.didDismiss(navigator)
            }
        }
    }
}

public extension UIViewController {
    func prefersLargeTitles(_ prefersLargeTitles: Bool = true) {
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    }
}

public extension UIViewController {
    
    // call this in viewWillDisappear(animated:) in the destination view controller when you leave the SHero enabled view controller and you want to disable SHero
    // already added in SViewController
    func disableHero() {
        navigationController?.hero.isEnabled = false
    }
    
    // call this in viewWillAppear(animated:) if you're coming from a view controller that has SHero disabled into a view controller that needs SHero enabled
    // needed if you can navigate back to this view controller with the navigationItem back button
    // already added in SViewController
    func enableHero() {
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
    }
    
    func showHero(_ viewController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        viewController.hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = navigationAnimationType
        navigationController?.pushViewController(viewController, animated: true)
    }
}

public extension UIViewController {
    func switchToTabBar(index: Int, delay: TimeInterval = 0.2) {
        let timeInterval = 0.2 + delay
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.switchTabBarController), userInfo: index, repeats: false)
    }
    
    @objc private func switchTabBarController(_ timer: Timer) {
        guard
            let tabBarController = UIWindow().getKeyWindow()?.rootViewController as? UITabBarController,
            let selectedIndex = timer.userInfo as? Int
            else { return }
        tabBarController.selectedIndex = selectedIndex
    }
}
