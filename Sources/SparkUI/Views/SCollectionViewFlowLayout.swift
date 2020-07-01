//
//  SCollectionViewFlowLayout.swift
//  
//
//  Created by Alex Nagy on 01/07/2020.
//

import UIKit

public class SCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public override init() {
        super.init()
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
