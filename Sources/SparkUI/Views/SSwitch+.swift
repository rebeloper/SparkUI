//
//  SSwitch+.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit

extension SSwitch {
    
    public func isOn() -> Bool? {
        object.isOn
    }
    
    @discardableResult
    public func onTintColor(_ onTintColor: UIColor?) -> SSwitch {
        object.onTintColor(onTintColor)
        return self
    }
    
    @discardableResult
    public func offTintColor(_ offTintColor: UIColor?) -> UISwitch {
        object.offTintColor(offTintColor)
        return self
    }
    
    @discardableResult
    public func onImage(_ onImage: UIImage?) -> SSwitch {
        object.onImage(onImage)
        return self
    }
    
    @discardableResult
    public func offImage(_ offImage: UIImage?) -> SSwitch {
        object.offImage(offImage)
        return self
    }
    
    @discardableResult
    public func isOn(_ isOn: Bool) -> SSwitch {
        object.isOn(isOn)
        return self
    }
    
    @discardableResult
    public func setSwitchBorder(width: CGFloat, color: UIColor) -> SSwitch {
        object.layer.borderWidth = width
        object.layer.cornerRadius = self.object.frame.height / 2
        object.layer.borderColor = color.cgColor
        object.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func setOn(_ setOn: Bool, animated: Bool = true) -> SSwitch {
        object.setOn(setOn, animated: animated)
        return self
    }
    
}

