//
//  UIApplication+.swift
//  
//
//  Created by Alex Nagy on 06/03/2020.
//

import UIKit

extension UIApplication {
    public static func openMailApp() {
        if let url = URL(string: "message://") {
            if self.shared.canOpenURL(url) {
                self.shared.open(url)
            } else {
                Alert.showError(message: "Could not open Mail app")
            }
        }
    }
    
    public static func preventsScreenDimming(_ preventsScreenDimming: Bool = true) {
        shared.isIdleTimerDisabled = preventsScreenDimming
    }
}
