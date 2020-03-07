//
//  SActivityController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public struct SActivityController {
    
    public static func share(title: String, message: String, image: UIImage) {
        
        let formattedMessage = "\n\(message)"
        
        let objectsToShare = [
            title,
            formattedMessage,
            image.withRenderingMode(.alwaysOriginal)
            ] as [Any]
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityViewController.setValue(title, forKey: "Subject")
        
        if let visibleViewController = visibleViewController() {
            // added for iPad
            activityViewController.popoverPresentationController?.sourceView = visibleViewController.view
            
            visibleViewController.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
    public static func share(title: String, message: String, url: URL, completion: @escaping () -> ()) {
        
        let formattedMessage = "\n\(message)"
        
        let objectsToShare = [
            title,
            formattedMessage,
            url
            ] as [Any]
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityViewController.setValue(title, forKey: "Subject")
        
        if let visibleViewController = visibleViewController() {
            // added for iPad
            activityViewController.popoverPresentationController?.sourceView = visibleViewController.view
            
            visibleViewController.present(activityViewController, animated: true) {
                completion()
            }
        }
        
    }
    
}


