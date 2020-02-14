//
//  SLabel.swift
//  
//
//  Created by Alex Nagy on 14/02/2020.
//

import UIKit

public class SLabel: UIView {
    
    public var element: UILabel?
    
    public init(uiLabel: UILabel) {
        self.element = uiLabel
        super.init(frame: .zero)
        
        addSubview(uiLabel)
        uiLabel.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
