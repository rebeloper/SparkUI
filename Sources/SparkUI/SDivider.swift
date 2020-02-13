//
//  SDivider.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public enum SDividerType {
    case vertical, horizontal
}

open class SDivider: UIView {
    
    public init(_ type: SDividerType = .vertical, thikness: CGFloat = 1.0, color: UIColor = .systemGray) {
        super.init(frame: .zero)
        self.backgroundColor = color
        switch type {
        case .vertical:
            setWidth(thikness)
        case .horizontal:
            setHeight(thikness)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
