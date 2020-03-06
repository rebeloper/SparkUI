//
//  STextFieldView.swift
//  
//
//  Created by Alex Nagy on 06/03/2020.
//

import UIKit
import Layoutless

public class STextFieldView: UIView {
    
    public var object: STextField?
    
    public init(sTextField: STextField, underlined: Bool = false) {
        self.object = sTextField
        super.init(frame: .zero)
        
        if underlined {
            let underline = SDivider()
            stack(.vertical)(
                sTextField,
                Spacer().setHeight(3),
                underline
                ).fillingParent().layout(in: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
