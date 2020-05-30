//
//  SSwipeToDeleteView.swift
//  
//
//  Created by Alex Nagy on 16/03/2020.
//

import UIKit
import Layoutless

open class SSwipeToDeleteView: UIView {
    
    public var width: CGFloat
    
    public let scrollingContainerView = UIView()
    public let containerView = UIView()
    
    public let deleteLabel = UILabel().font(.boldSystemFont(ofSize: 17)).text(color: .systemWhite).text("Delete")
    public let deleteContainerView = UIView().setBackground(color: .systemRed)
    
    public var scrollView: UIScrollView?
    
    public var didDelete = Bucket(false)
    
    public init(width: CGFloat) {
        if width == 0 {
            fatalError("Width is 0. This usually happens when a view is reused, like a UICollectionViewCell. Consider using 'UIScreen.main.bounds.size.width' instead of 'self.frame.width' to set the width of the SSwipeToDeleteView view")
        }
        self.width = width
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    public func setupView() {
        backgroundColor = .systemBackground
        scrollingContainerView.backgroundColor = .systemBackground
        containerView.backgroundColor = .systemBackground
        layoutViews()
        bind()
        observe()
        continueInit()
    }
    
    open func layoutViews() {
        
        stack(.horizontal)(
            Spacer().setWidth(12),
            deleteLabel,
            Spacer()
        ).fillingParent().layout(in: deleteContainerView)
        
        stack(.horizontal, distribution: .fillEqually)(
            containerView.setWidth(width),
            deleteContainerView.setWidth(width)
        ).scrolling(.horizontal, configure: { (scrollView) in
            self.scrollView = scrollView
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.delegate = self
            scrollView.bounces = false
        }).fillingParent().layout(in: scrollingContainerView)
        
        stack(.vertical)(
            scrollingContainerView
        ).fillingParent().layout(in: self)
        
    }
    
    open func bind() {}
    open func observe() {}
    open func continueInit() {}
    
    public func reset() {
        guard let scrollView = self.scrollView else { return }
        SDispatchQueue.delay(bySeconds: 0.4) {
            scrollView.contentOffset.x = 0
        }
    }
}

extension SSwipeToDeleteView: UIScrollViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= self.frame.width {
            didDelete.setValue(true)
        }
    }
}
