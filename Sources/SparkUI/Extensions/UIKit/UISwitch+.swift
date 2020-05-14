//
//  UISwitch+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

public extension UISwitch {
    
    @discardableResult
    func onTintColor(_ onTintColor: UIColor?) -> UISwitch {
        self.onTintColor = onTintColor
        return self
    }
    
    @discardableResult
    func offTintColor(_ offTintColor: UIColor?) -> UISwitch {
        tintColor = offTintColor
        layer.cornerRadius = frame.height / 2
        backgroundColor = offTintColor
        return self
    }
    
    @discardableResult
    func thumbTintColor(_ thumbTintColor: UIColor?) -> UISwitch {
        self.thumbTintColor = thumbTintColor
        return self
    }
    
    @discardableResult
    func onImage(_ onImage: UIImage?) -> UISwitch {
        self.onImage = onImage
        return self
    }
    
    @discardableResult
    func offImage(_ offImage: UIImage?) -> UISwitch {
        self.offImage = offImage
        return self
    }
    
    @discardableResult
    func setToOn(_ on: Bool = true, animated: Bool = true) -> UISwitch {
        self.setOn(on, animated: animated)
        return self
    }
    
    @discardableResult
    func setToOff(_ off: Bool = true, animated: Bool = true) -> UISwitch {
        self.setOn(!off, animated: animated)
        return self
    }
    
    @discardableResult
    func setSwitchBorder(width: CGFloat, color: UIColor) -> UISwitch {
        layer.borderWidth = width
        layer.cornerRadius = self.frame.height / 2
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
}

public extension UISwitch {
    func addAction(completion: @escaping (_ isOn: Bool) -> ()) {
        self.addAction(events: [.valueChanged]) { (uiSwitch: UISwitch) in
            completion(uiSwitch.isOn)
        }
    }
}
