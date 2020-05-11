//
//  SCollectionReusableView.swift
//  
//
//  Created by Alex Nagy on 11/05/2020.
//

import UIKit

open class SCollectionReusableView: UICollectionReusableView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layoutViews()
        observe()
    }
    
    required public init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    open func layoutViews() {}
    open func observe() {}
}
