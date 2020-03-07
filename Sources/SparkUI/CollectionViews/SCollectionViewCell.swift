//
//  SCollectionViewCell.swift
//  
//
//  Created by Alex Nagy on 21/02/2020.
//

import UIKit

public class SCollectionViewCell: UICollectionViewCell {
    
    public let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        container.backgroundColor = .systemBackground
        layoutViews()
        bind()
        observe()
        continueInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func layoutViews() {
        addSubview(container)
        container.edgeTo(self)
    }
    
    open func bind() {}
    open func observe() {}
    open func continueInit() {}
}
