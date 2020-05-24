//
//  SCollectionSupplementaryView.swift
//  
//
//  Created by Alex Nagy on 11/05/2020.
//

import UIKit
import Layoutless

open class SCollectionSupplementaryView<T>: UICollectionReusableView {

    open var item: T? {
        didSet {
            layoutViews()
            configureViews(for: self.item)
        }
    }

    open var indexPath: IndexPath?
    open var reuse = true

    public let container = UIView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        assign()
        addActions()
        onNext()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        if !reuse {
            layoutViews()
            configureViews(for: self.item)
        }
    }

    open func layoutViews() {
        stack(.vertical)(
            container
        ).fillingParent().layout(in: self)
    }

    open func configureViews(for item: T?) {
        setSupplementaryViewBackgroundColor()
    }
    
    open func assign() {}
    open func addActions() {}
    open func onNext() {}
    
    public func setSupplementaryViewBackgroundColor(_ backgroundColor: UIColor,
                                   containerBackgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        container.backgroundColor = containerBackgroundColor
    }
    
    public func setSupplementaryViewBackgroundColor(all color: UIColor = .systemBackground) {
        setSupplementaryViewBackgroundColor(color, containerBackgroundColor: color)
    }

}



