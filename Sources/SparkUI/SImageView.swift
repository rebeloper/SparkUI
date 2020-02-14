//
//  SImageView.swift
//  
//
//  Created by Alex Nagy on 14/02/2020.
//

import UIKit

public class SImageView: UIView {
    
    public var element: UIImageView?
    
    public init(uiImageView: UIImageView) {
        self.element = uiImageView
        super.init(frame: .zero)
        
        addSubview(uiImageView)
        uiImageView.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
