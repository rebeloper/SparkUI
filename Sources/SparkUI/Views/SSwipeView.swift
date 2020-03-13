//
//  SSwipeView.swift
//  
//
//  Created by Alex Nagy on 13/03/2020.
//

import UIKit
import Layoutless

open class SSwipeView: UIView {
    
    public var object = UIView()
    
    public init(size: CGSize = CGSize(width: 100, height: 4), color: UIColor = UIColor.systemGray.withAlphaComponent(0.5), backgroundColor: UIColor = .systemBackground, edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        object.setSize(size).setBackground(color: color).setCorner(size.height / 2)
        
        stack(.vertical)(
            stack(.horizontal, distribution: .equalCentering)(
                Spacer(),
                object,
                Spacer()
            )
            ).insetting(by: edgeInsets).fillingParent().layout(in: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
