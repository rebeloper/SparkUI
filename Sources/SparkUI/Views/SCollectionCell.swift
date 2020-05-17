//
//  SCollectionCell.swift
//  
//
//  Created by Alex Nagy on 11/05/2020.
//

import UIKit
import Layoutless

open class SCollectionCell<T>: UICollectionViewCell {
    
    public var item: T? {
        didSet {
            layoutViews()
            configureViews(for: self.item)
        }
    }
    
    public var indexPath: IndexPath?
    public var reuse = true
    
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
        ).fillingParent().layout(in: contentView)
    }
    
    open func configureViews(for item: T?) {
        setBackgroundColor()
    }
    
    open func assign() {}
    open func addActions() {}
    open func onNext() {}
    
    public func setBackgroundColor(selectedBackgroundViewColor: UIColor,
                                   backgroundColor: UIColor,
                                   contentViewBackgroundColor: UIColor,
                                   containerBackgroundColor: UIColor) {
        selectedBackgroundView = UIView().setBackground(color: selectedBackgroundViewColor)
        self.backgroundColor = backgroundColor
        contentView.backgroundColor = contentViewBackgroundColor
        container.backgroundColor = containerBackgroundColor
    }
    
    public func setBackgroundColor(all color: UIColor = .systemBackground) {
        setBackgroundColor(selectedBackgroundViewColor: color, backgroundColor: color, contentViewBackgroundColor: color, containerBackgroundColor: color)
    }
}
