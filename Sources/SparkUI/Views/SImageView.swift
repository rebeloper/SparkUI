//
//  SImageView.swift
//  
//
//  Created by Alex Nagy on 14/02/2020.
//

import UIKit

public class SImageView: UIView {
    
    public var object: UIImageView!
    
    public init(uiImageView: UIImageView = UIImageView()) {
        self.object = uiImageView
        super.init(frame: .zero)
        
        addSubview(uiImageView)
        uiImageView.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
}
