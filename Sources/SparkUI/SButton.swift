//
//  SButton.swift
//  
//
//  Created by Alex Nagy on 14/02/2020.
//

import UIKit

public class SButton: UIView {
    
    public var button: UIButton?
    
    public init(_ button: UIButton) {
        self.button = button
        super.init(frame: .zero)
        
        addSubview(button)
        button.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

