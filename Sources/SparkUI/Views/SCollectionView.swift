//
//  SCollectionView.swift
//  
//
//  Created by Alex Nagy on 01/07/2020.
//

import UIKit

public class SCollectionView<T: CollectionCell<Any>>: UICollectionView {
    
    public init(with layout: UICollectionViewFlowLayout, cellId cellReuseIdentifier: String, delegateAndDataSource: UIViewController?, backgroundColor: UIColor = .systemBackground) {
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(T.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.delegate = delegateAndDataSource as? UICollectionViewDelegate
        self.dataSource = delegateAndDataSource as? UICollectionViewDataSource
        self.backgroundColor = backgroundColor
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
