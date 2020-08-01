//
//  CoreDataFetchedResults.swift
//  
//
//  Created by Alex Nagy on 17/07/2020.
//

import UIKit
import CoreData

public class CoreDataFetchedResults<T: NSManagedObject> {
    
    var entityName: String!
    var sortDescriptors: [NSSortDescriptor]!
    public var managedContext: NSManagedObjectContext!
    var delegate: UIViewController?
    var sectionNameKeyPath: String?
    var cacheName: String?
    var usesFatalError: Bool!
    
    public lazy var controller: NSFetchedResultsController<T> = {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedContext,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName)
        
        fetchedResultsController.delegate = delegate as? NSFetchedResultsControllerDelegate
        
        return fetchedResultsController
    }()
    
    public init(ofType _: T.Type, entityName: String, sortDescriptors: [NSSortDescriptor], managedContext: NSManagedObjectContext, delegate: UIViewController?, sectionNameKeyPath: String? = nil, cacheName: String? = nil, usesFatalError: Bool = false) {
        self.entityName = entityName
        self.sortDescriptors = sortDescriptors
        self.managedContext = managedContext
        self.delegate = delegate
        self.sectionNameKeyPath = sectionNameKeyPath
        self.cacheName = cacheName
        self.usesFatalError = usesFatalError
    }
    
    public func saveContext(completion: @escaping (Result<Bool, Error>) -> () = {_ in}) {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
            completion(.success(true))
        } catch {
            handle(error) {
                completion(.failure(error))
            }
        }
    }
    
    public func performFetch(completion: @escaping (Result<Bool, Error>) -> () = {_ in}) {
        do {
            try controller.performFetch()
        } catch {
            handle(error) {
                completion(.failure(error))
            }
        }
    }
    
    private func handle(_ error: Error?, completion: @escaping () -> () = {}) {
        if let error = error as NSError? {
            let message = "CoreDataFetchedResults -> \(#function): Unresolved error: \(error), \(error.userInfo)"
            if usesFatalError {
                fatalError(message)
            } else {
                print(message)
            }
            completion()
        }
    }
    
}

