//
//  SCollectionViewController.swift
//  
//
//  Created by Alex Nagy on 11/05/2020.
//

import UIKit
import Layoutless

open class SCollectionViewController: SViewController {
    
    public enum Section {
        case main
    }
    
    public var collectionView: UICollectionView! = nil
    
    required public init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewHierarchy()
        configureCollectionViewDataSource()
    }
    
    open override func layoutViews() {
        super.layoutViews()
        
        stack(.vertical)(
            collectionView
            ).fillingParent().layout(in: container)
    }
    
    open func configureCollectionViewHierarchy() {}
    open func configureCollectionViewDataSource() {}
    
}

