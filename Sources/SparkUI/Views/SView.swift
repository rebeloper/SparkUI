//
//  SView.swift
//  
//
//  Created by Alex Nagy on 01/04/2020.
//

import UIKit

public class SView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemWhite
    }
    
    public required init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
}
