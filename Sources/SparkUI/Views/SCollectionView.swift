//
//  SCollectionView.swift
//  
//
//  Created by Alex Nagy on 01/07/2020.
//

import UIKit

public class SCollectionView: UICollectionView {
    
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    init(with layout: UICollectionViewFlowLayout, and backgroundColor: UIColor = .systemBackground) {
        super.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = backgroundColor
    }
    
    init(with layout: UICollectionViewFlowLayout, delegateAndDataSource: UIViewController?, and backgroundColor: UIColor = .systemBackground) {
        super.init(frame: .zero, collectionViewLayout: layout)
        self.delegate = delegateAndDataSource as? UICollectionViewDelegate
        self.dataSource = delegateAndDataSource as? UICollectionViewDataSource
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
