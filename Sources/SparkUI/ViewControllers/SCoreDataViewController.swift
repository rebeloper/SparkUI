//
//  SCoreDataViewController.swift
//  
//
//  Created by Alex Nagy on 09/07/2020.
//

import UIKit
import CoreData

open class SCoreDataViewController: SViewController {
    
    // MARK: - Dependencies
    
    public var coreDataStack: CoreDataStack!
    
    public init(safeArea: SSafeArea, coreDataStack: CoreDataStack) {
        super.init(safeArea: safeArea)
        self.coreDataStack = coreDataStack
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
