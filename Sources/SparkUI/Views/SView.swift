//
//  SView.swift
//  
//
//  Created by Alex Nagy on 01/04/2020.
//

import UIKit

class SView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
