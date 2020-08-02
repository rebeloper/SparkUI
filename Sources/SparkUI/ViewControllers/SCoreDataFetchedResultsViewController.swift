//
//  SCoreDataFetchedResultsViewController.swift
//  
//
//  Created by Alex Nagy on 02/08/2020.
//

import UIKit
import CoreData

open class SCoreDataFetchedResultsViewController<T: NSManagedObject>: SViewController {
    
    // MARK: - Dependencies
    
    public var coreDataFetchedResults: CoreDataFetchedResults<T>!
    
    public init(safeArea: SSafeArea, coreDataFetchedResults: CoreDataFetchedResults<T>) {
        super.init(safeArea: safeArea)
        self.coreDataFetchedResults = coreDataFetchedResults
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
