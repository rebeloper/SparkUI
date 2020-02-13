//
//  SHud.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import JGProgressHUD
import SparkExtensions

public enum SHudType {
    case none
    case show
    case update
    case success
    case error
    case close
    case closeWithAlert
    case closeWithSuccessAlert
    case closeWithErrorAlert
}

public struct SHudInfo {
    let type: SHudType
    let text: String
    let detailText: String
    
    public init(type: SHudType, text: String = "", detailText: String = "") {
        self.type = type
        self.text = text
        self.detailText = detailText
    }
}

public let closeHudInfo = SHudInfo(type: .close, text: "", detailText: "")

public class SHud {
    
    // MARK: -
    // MARK: Handle hud
    
    public static func handle(_ hud: JGProgressHUD, with info: SHudInfo) {
        switch info.type {
        case .none:
            return
        case .show:
            show(hud, text: info.text, detailText: info.detailText)
        case .update:
            change(hud, text: info.text, detailText: info.detailText)
        case .success:
            dismiss(hud, type: info.type, text: info.text, detailText: info.detailText)
        case .error:
            dismiss(hud, type: info.type, text: info.text, detailText: info.detailText)
        case .close:
            hud.dismiss(animated: true)
        case .closeWithAlert:
            closeWithAlert(hud, text: info.text, detailText: info.detailText)
        case .closeWithSuccessAlert:
            closeWithSuccessAlert(hud, detailText: info.detailText)
        case .closeWithErrorAlert:
            closeWithErrorAlert(hud, detailText: info.detailText)
        }
    }
    
    // MARK: -
    // MARK: Create hud
    
    public static func create() -> JGProgressHUD {
        if let visibleViewController = visibleViewController() {
            visibleViewController.traitCollection.userInterfaceStyle == .dark ? create(style: .dark) : create(style: .light)
        } else {
            create(style: .light)
        }
        
    }
    
    fileprivate static func create(style: JGProgressHUDStyle) -> JGProgressHUD {
        let hud = JGProgressHUD(style: style)
        hud.interactionType = .blockAllTouches
        return hud
    }
    
    // MARK: -
    // MARK: Show hud
    
    static func show(_ hud: JGProgressHUD, text: String, detailText: String = "") {
        hud.textLabel.text = text
        if detailText != "" {
            hud.detailTextLabel.text = detailText
        }
        if let visibleViewController = visibleViewController() {
            hud.show(in: visibleViewController.view)
        }
    }
    
    // MARK: -
    // MARK: Change hud
    
    static func change(_ hud: JGProgressHUD, text: String, detailText: String = "") {
        hud.textLabel.text = text
        if detailText != "" {
            hud.detailTextLabel.text = detailText
        }
    }
    
    // MARK: -
    // MARK: Dismiss hud
    
    static func dismiss(_ hud: JGProgressHUD, type: SHudType, text: String, detailText: String) {
        DispatchQueue.main.async {
            hud.textLabel.text = text
            hud.detailTextLabel.text = detailText
            let delay = type == .success ? TimeInterval(0.5) : TimeInterval(1.0)
            hud.dismiss(afterDelay: delay , animated: true)
        }
    }
    
    // MARK: -
    // MARK: Close hud with alert
    
    static func closeWithAlert(_ hud: JGProgressHUD, text: String, detailText: String) {
        SAlertController.showAlert(style: .alert, title: text, message: detailText)
        handle(hud, with: closeHudInfo)
    }
    
    // MARK: -
    // MARK: Close hud with success alert
    
    static func closeWithSuccessAlert(_ hud: JGProgressHUD, detailText: String) {
        SAlertController.showAlert(style: .alert, title: "Success", message: detailText)
        handle(hud, with: closeHudInfo)
    }
    
    // MARK: -
    // MARK: Close hud with error alert
    
    static func closeWithErrorAlert(_ hud: JGProgressHUD, detailText: String) {
        SAlertController.showAlert(style: .alert, title: "Error", message: detailText)
        handle(hud, with: closeHudInfo)
    }
    
}
