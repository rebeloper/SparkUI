//
//  SCollectionViewCell.swift
//  
//
//  Created by Alex Nagy on 21/02/2020.
//

import UIKit
import ReactiveKit
import Layoutless

open class SCollectionViewCell: UICollectionViewCell {
    
    public let container = UIView()
    public let cellContainerView = UIView()
    
    public let deleteView = SSwipeToDeleteView()
    
    public func setupCell(deletable: Bool = true) {
        backgroundColor = .systemBackground
        container.backgroundColor = .systemBackground
        layoutViews(deletable: deletable)
        bind()
        observe()
        continueInit()
    }
    
    open func layoutViews(deletable: Bool) {
        
        if deletable {
            stack(.vertical)(
                deleteView
            ).fillingParent().layout(in: self)
        } else {
            stack(.vertical)(
                cellContainerView
            ).fillingParent().layout(in: self)
        }
        
    }
    
    open func bind() {}
    open func observe() {}
    open func continueInit() {}
    
    public func reset() {
        deleteView.reset()
    }
}
