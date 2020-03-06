//
//  SApplication.swift
//  
//
//  Created by Alex Nagy on 06/03/2020.
//

import UIKit

struct SApplication {
    
    static func openMailApp() {
        if let url = URL(string: "message://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                SAlertController.showError(message: "Could not open Mail app")
            }
        }
    }
}
