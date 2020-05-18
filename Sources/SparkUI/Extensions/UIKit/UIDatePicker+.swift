//
//  UIDatePicker+.swift
//  
//
//  Created by Alex Nagy on 18/05/2020.
//

import UIKit

public extension UIDatePicker {
    
    @discardableResult
    func date(_ date: Date) -> UIDatePicker {
        self.date = date
        return self
    }
    
    @discardableResult
    func datePickerMode(_ datePickerMode: UIDatePicker.Mode) -> UIDatePicker {
        self.datePickerMode = datePickerMode
        return self
    }
    
    @discardableResult
    func addAction(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> UIDatePicker {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
}
