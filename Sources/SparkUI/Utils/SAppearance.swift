//
//  SAppearance.swift
//  
//
//  Created by Alex Nagy on 01/04/2020.
//

import UIKit

public struct SAppearance {
    public static func get() -> SAppearenceType {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return SAppearenceType.dark
            } else {
                return SAppearenceType.light
            }
        } else {
            print("UITraitCollection is not available pre-iOS13, but returning SAppearenceType.light")
            return SAppearenceType.light
        }
    }
}


