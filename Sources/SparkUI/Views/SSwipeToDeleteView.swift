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
    
    public let container = UIView()
    public let cellContainerView = UIView()
    
    public let deleteLabel = UILabel().font(.boldSystemFont(ofSize: 17)).text(color: .white).text("Delete")
    public let deleteContainerView = UIView().setBackground(color: .systemRed)
    
    public var scrollView: UIScrollView?
    
    public var didDelete = Property(false)
    
    public func setupView() {
        backgroundColor = .systemBackground
        container.backgroundColor = .systemBackground
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
            cellContainerView.setWidth(self.frame.width),
            deleteContainerView.setWidth(self.frame.width)
        ).scrolling(.horizontal, configure: { (scrollView) in
            self.scrollView = scrollView
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.delegate = self
            scrollView.bounces = false
        }).fillingParent().layout(in: container)
        
        stack(.vertical)(
            container
        ).fillingParent().layout(in: self)
        
    }
    
    open func bind() {}
    open func observe() {}
    open func continueInit() {}
    
    public func reset() {
        guard let scrollView = self.scrollView else { return }
        SDispatchQueue.delay(bySeconds: 1) {
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
