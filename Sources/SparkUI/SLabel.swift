//
//  SLabel.swift
//  
//
//  Created by Alex Nagy on 14/02/2020.
//

import UIKit

public class SLabel: UIView {
    
    public var label: UILabel?
    
    public init(_ label: UILabel) {
        self.label = label
        super.init(frame: .zero)
        
        addSubview(label)
        label.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
