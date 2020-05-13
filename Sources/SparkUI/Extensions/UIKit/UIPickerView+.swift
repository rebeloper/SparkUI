//
//  UIPickerView+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

public extension UIPickerView {
    
    @discardableResult
    func delegate(_ delegate: UIViewController) -> UIPickerView {
        self.delegate = delegate as! UIPickerViewDataSource & UIPickerViewDelegate
        return self
    }
    
    @discardableResult
    func delegateView(_ delegateView: UIView) -> UIPickerView {
        self.delegate = delegateView as! UIPickerViewDataSource & UIPickerViewDelegate
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int) -> UIPickerView {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func select(_ row: Int, inComponent: Int = 0, animated: Bool = false) -> UIPickerView {
        self.selectRow(row, inComponent: inComponent, animated: animated)
        return self
    }
}

