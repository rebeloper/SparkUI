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
    
    public let deleteLabel = UILabel().font(.boldSystemFont(ofSize: 17)).text(color: .white).text("Delete")
    public let deleteContainerView = UIView().setBackground(color: .systemRed)
    
    public var scrollView: UIScrollView?
    
    public var didDelete = Property(false)
    
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
        } else {
            stack(.vertical)(
                cellContainerView
            ).fillingParent().layout(in: self)
        }
        
    }
    
    open func bind() {}
    open func observe() {}
    open func continueInit() {}
    
    public func resetCell() {
        guard let scrollView = self.scrollView else { return }
        SDispatchQueue.delay(bySeconds: 1) {
            scrollView.contentOffset.x = 0
        }
    }
}

extension SCollectionViewCell: UIScrollViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= self.frame.width {
            didDelete.value = true
        }
    }
}
