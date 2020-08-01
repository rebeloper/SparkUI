//
//  Console.swift
//
//
//  Created by Alex Nagy on 01/08/2020.
//

import UIKit

internal extension UIViewController {
    func removeAllChildren() {
        children.forEach {
            $0.willMove(toParent: nil)
        }
        
        for view in view.subviews {
            view.removeFromSuperview()
        }
        children.forEach {
            $0.removeFromParent()
        }
    }
}
