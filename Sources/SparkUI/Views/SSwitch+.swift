//
//  SSwitch+.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit

public extension SSwitch {
    
    func isOn() -> Bool? {
        object.isOn
    }
    
    @discardableResult
    func onTintColor(_ onTintColor: UIColor?) -> SSwitch {
        object.onTintColor(onTintColor)
        return self
    }
    
    @discardableResult
    func offTintColor(_ offTintColor: UIColor?) -> SSwitch {
        object.offTintColor(offTintColor)
        return self
    }
    
    @discardableResult
    func onImage(_ onImage: UIImage?) -> SSwitch {
        object.onImage(onImage)
        return self
    }
    
    @discardableResult
    func offImage(_ offImage: UIImage?) -> SSwitch {
        object.offImage(offImage)
        return self
    }
    
    @discardableResult
    func setSwitchBorder(width: CGFloat, color: UIColor) -> SSwitch {
        object.layer.borderWidth = width
        object.layer.cornerRadius = self.object.frame.height / 2
        object.layer.borderColor = color.cgColor
        object.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setToOn(_ on: Bool = true, animated: Bool = true) -> SSwitch {
        object.setOn(on, animated: animated)
        return self
    }
    
    @discardableResult
    func setToOff(_ off: Bool = true, animated: Bool = true) -> SSwitch {
        object.setOn(!off, animated: animated)
        return self
    }
    
}

public extension SSwitch {
    func addAction(completion: @escaping (Bool) -> ()) {
        object.addAction(completion: completion)
    }
}

