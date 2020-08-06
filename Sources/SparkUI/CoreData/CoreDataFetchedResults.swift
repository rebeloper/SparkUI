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
    var predicate: NSPredicate?
    public var coreDataStack: CoreDataStack!
    public var delegate: UIViewController?
    var sectionNameKeyPath: String?
    var cacheName: String?
    var usesFatalError: Bool!
    
    public lazy var controller: NSFetchedResultsController<T> = {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        if let predicate = self.predicate {
            fetchRequest.predicate = predicate
        }
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName)
        
        fetchedResultsController.delegate = delegate as? NSFetchedResultsControllerDelegate
        
        return fetchedResultsController
    }()
    
    public init(ofType _: T.Type, entityName: String, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate? = nil, coreDataStack: CoreDataStack, delegate: UIViewController?, sectionNameKeyPath: String? = nil, cacheName: String? = nil, usesFatalError: Bool = false) {
        self.entityName = entityName
        self.sortDescriptors = sortDescriptors
        self.predicate = predicate
        self.coreDataStack = coreDataStack
        self.delegate = delegate
        self.sectionNameKeyPath = sectionNameKeyPath
        self.cacheName = cacheName
        self.usesFatalError = usesFatalError
    }
    
    public func saveContext(completion: @escaping (Result<Bool, Error>) -> () = {_ in}) {
        guard coreDataStack.managedContext.hasChanges else { return }
        
        do {
            try coreDataStack.managedContext.save()
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
            completion(.success(true))
        } catch {
            handle(error) {
                completion(.failure(error))
            }
        }
    }
    
    public func count(completion: @escaping (Result<Int, Error>) -> ()) {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let count = try coreDataStack.managedContext.count(for: fetchRequest)
            completion(.success(count))
        } catch {
            handle(error) {
                completion(.failure(error))
            }
        }
    }
    
    public func delete(_ object: NSManagedObject, completion: @escaping (Result<Bool, Error>) -> () = {_ in}) {
        self.coreDataStack.managedContext.delete(object)
        self.coreDataStack.saveContext(completion: completion)
    }
    
    private func handle(_ error: Error?, completion: @escaping () -> () = {}) {
        if let error = error as NSError? {
            let message = "CoreDataFetchedResults -> \(#function): Unresolved error: \(error), \(error.userInfo)"
            if usesFatalError {
                fatalError(message)
            } else {
                Console.print(message)
            }
            completion()
        }
    }
    
}

