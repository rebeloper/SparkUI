//
//  UISwitch+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

extension UISwitch {
    
    @discardableResult
    public func onTintColor(_ onTintColor: UIColor?) -> UISwitch {
        self.onTintColor = onTintColor
        return self
    }
    
    @discardableResult
    public func thumbTintColor(_ thumbTintColor: UIColor?) -> UISwitch {
        self.thumbTintColor = thumbTintColor
        return self
    }
    
    @discardableResult
    public func onImage(_ onImage: UIImage?) -> UISwitch {
        self.onImage = onImage
        return self
    }
    
    @discardableResult
    public func offImage(_ offImage: UIImage?) -> UISwitch {
        self.offImage = offImage
        return self
    }
    
    @discardableResult
    public func isOn(_ isOn: Bool) -> UISwitch {
        self.isOn = isOn
        return self
    }
    
}

