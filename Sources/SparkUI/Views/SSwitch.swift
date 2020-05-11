//
//  SSwitch.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit

public class SSwitch: UIView {
    
    public var object: UISwitch!
    
    public init(uiSwitch: UISwitch) {
        self.object = uiSwitch
        super.init(frame: .zero)
        
        addSubview(uiSwitch)
        uiSwitch.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    
}
