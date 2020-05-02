//
//  SAlertController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public typealias Alert = SAlertController

public class SAlertController {
    
    public static func show(_ style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        if let visibleViewController = visibleViewController() {
            alert.popoverPresentationController?.sourceView = visibleViewController.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: visibleViewController.view.bounds.midX, y: visibleViewController.view.bounds.midY, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
            visibleViewController.present(alert, animated: true, completion: completion)
        }
    }
    
    public static func show(_ style: UIAlertController.Style, title: String?, message: String?, textFields: [UITextField], submitActionTitle: String = "Submit", completion: @escaping ([String]?) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for textField in textFields {
            alert.addTextField(configurationHandler: { (theTextField) in
                theTextField.placeholder = textField.placeholder
                theTextField.autocapitalizationType = textField.autocapitalizationType
                theTextField.font = textField.font
            })
        }
        
        let textFieldAction = UIAlertAction(title: submitActionTitle, style: .default) { (action) in
            var textFieldsTexts: [String] = []
            if let alertTextFields = alert.textFields {
                for textField in alertTextFields {
                    if let textFieldText = textField.text {
                        textFieldsTexts.append(textFieldText)
                    }
                }
                completion(textFieldsTexts)
            }
        }
        alert.addAction(textFieldAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            completion(nil)
        }
        alert.addAction(cancelAction)
        
        if let visibleViewController = visibleViewController() {
            alert.popoverPresentationController?.sourceView = visibleViewController.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: visibleViewController.view.bounds.midX, y: visibleViewController.view.bounds.midY, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
            visibleViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showInfo(message: String) {
        show(.alert, title: "Info", message: message)
    }
    
    public static func showSuccess(message: String) {
        show(.alert, title: "Success", message: message)
    }
    
    public static func showWarning(message: String) {
        show(.alert, title: "Warning", message: message)
    }
    
    public static func showError(message: String) {
        show(.alert, title: "Error", message: message)
    }
    
    public static func defaultAction(title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default)
    }
    
    public static func destructiveAction(title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .destructive)
    }
    
    public static func cancelAction(title: String = "Cancel") -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel)
    }
    
    public static func okAction(title: String = "Ok", style: UIAlertAction.Style = .default) -> UIAlertAction {
        return UIAlertAction(title: title, style: style)
    }
    
}
