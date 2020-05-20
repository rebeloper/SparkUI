//
//  SKeyboard.swift
//  
//
//  Created by Alex Nagy on 20/05/2020.
//

import UIKit
import Foundation

public class SKeyboard {
    
    public static let listener = SKeyboard()
    
    public var isVisible = false
    
    public func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleShow() {
        isVisible = true
    }
    
    @objc func handleHide() {
        isVisible = false
    }
    
    public func stop() {
        NotificationCenter.default.removeObserver(self)
    }
}

