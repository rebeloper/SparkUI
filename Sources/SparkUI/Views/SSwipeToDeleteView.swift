//
//  SSwipeToDeleteView.swift
//  
//
//  Created by Alex Nagy on 16/03/2020.
//

import UIKit
import ReactiveKit
import Layoutless

open class SSwipeToDeleteView: UIView {
    
    public var width: CGFloat = 0
    
    public let scrollingContainerView = UIView()
    public let containerView = UIView()
    
    public let deleteLabel = UILabel().font(.boldSystemFont(ofSize: 17)).text(color: .white).text("Delete")
    public let deleteContainerView = UIView().setBackground(color: .systemRed)
    
    public var scrollView: UIScrollView?
    
    public var didDelete = Property(false)
    
    public init(width: CGFloat) {
        super.init(frame: .zero)
        self.width = width
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            didDelete.value = true
        }
    }
}
