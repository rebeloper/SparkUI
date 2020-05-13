//
//  UIApplication+.swift
//  
//
//  Created by Alex Nagy on 06/03/2020.
//

import UIKit

public extension UIApplication {
    static func openMailApp() {
        if let url = URL(string: "message://") {
            if self.shared.canOpenURL(url) {
                self.shared.open(url)
            } else {
                Alert.showError(message: "Could not open Mail app")
            }
        }
    }
    
    static func preventsScreenDimming(_ preventsScreenDimming: Bool = true) {
        shared.isIdleTimerDisabled = preventsScreenDimming
    }
}
