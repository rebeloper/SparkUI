//
//  Console.swift
//
//
//  Created by Alex Nagy on 01/08/2020.
//

import UIKit
import MessageUI

internal extension UIAlertAction {
    static let cancel: UIAlertAction = {
        UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }()
    
    static let clear: UIAlertAction = {
        UIAlertAction(title: "Clear", style: .destructive) {
            (action: UIAlertAction) in
            Console.clear()
        }
    }()
    
    static func okAddLog(with alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: "Add Log", style: .default) {
            (action: UIAlertAction) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            Console.print(text)
        }
    }
    
    static func ok() -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: nil)
    }
    
    static func okSetHeight(with alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: "Set Height", style: .default) {
            (action: UIAlertAction) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty, let height = Int(text) else {
                return
            }
            var cgFloatHeight = CGFloat(height)
            if cgFloatHeight < Console.consoleHeight { cgFloatHeight = Console.consoleHeight }
            Console.setHeight(height: cgFloatHeight)
        }
    }
}
