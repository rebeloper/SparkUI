//
//  SAppearance.swift
//  
//
//  Created by Alex Nagy on 01/04/2020.
//

import UIKit

public struct SAppearance {
    
    public static func get() -> SAppearenceMode {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return SAppearenceMode.dark
            } else {
                return SAppearenceMode.light
            }
        } else {
            return SAppearenceMode.preiOS13
        }
    }
    
    public struct NavigationBar {
        public static func setTransparency(to backgroundColor: UIColor?, tintColor: UIColor = .systemBlue) {
            if backgroundColor == .clear {
                UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
                UINavigationBar.appearance().shadowImage = UIImage()
                UINavigationBar.appearance().isTranslucent = true
            } else {
                UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
                UINavigationBar.appearance().shadowImage = nil
            }
            UINavigationBar.appearance().backgroundColor = backgroundColor
            UINavigationBar.appearance().tintColor = tintColor
        }
        
        public static func resetTransparencyToDefault() {
            UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
            UINavigationBar.appearance().shadowImage = nil
            UINavigationBar.appearance().backgroundColor = nil
        }
    }
    
    public struct SegmentedControl {
        public static func set(primaryColor: UIColor = .systemBlue, secondaryColor: UIColor = .systemBackground) {
            UISegmentedControl.appearance().selectedSegmentTintColor = primaryColor
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: secondaryColor], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: primaryColor], for: .normal)
        }
    }
}


