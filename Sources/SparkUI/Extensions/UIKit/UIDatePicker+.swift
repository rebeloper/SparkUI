//
//  UIDatePicker+.swift
//  
//
//  Created by Alex Nagy on 18/05/2020.
//

import UIKit

public struct UIDatePickerDate {
    static let selectedDate = Bucket(Date())
}

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
    func addAction() -> UIDatePicker {
        self.addTarget(self, action: #selector(pickerViewSelected(sender:)), for: .valueChanged)
        return self
    }
    
    @objc fileprivate func pickerViewSelected(sender: UIDatePicker) {
        UIDatePickerDate.selectedDate.value = sender.date
    }
}
