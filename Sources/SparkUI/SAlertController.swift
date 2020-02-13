//
//  SAlertController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import Foundation
import SparkExtensions

public class SAlertController {
    
    public static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
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
    
    public static func showAlert(style: UIAlertController.Style, title: String?, message: String?, textFields: [UITextField], submitActionTitle: String = "Submit", completion: @escaping ([String]?) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for textField in textFields {
            alert.addTextField(configurationHandler: { (theTextField) in
                theTextField.placeholder = textField.placeholder
            })
        }
        
        let textFieldAction = UIAlertAction(title: submitActionTitle, style: .defaul) { (action) in
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
    
}
