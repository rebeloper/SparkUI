//
//  CoreDataStack.swift
//  
//
//  Created by Alex Nagy on 09/07/2020.
//

import Foundation
import CoreData

public class CoreDataStack {
    
    private let modelName: String
    private let usesCloudKit: Bool
    private let usesFatalError: Bool
    
    public init(modelName: String, usesCloudKit: Bool = false, usesFatalError: Bool = false) {
        self.modelName = modelName
        self.usesCloudKit = usesCloudKit
        self.usesFatalError = usesFatalError
    }
    
    public lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        
        if usesCloudKit {
            
            let container = NSPersistentCloudKitContainer(name: self.modelName)
            container.loadPersistentStores { (storeDescription, error) in
                self.handle(error)
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
            
            do {
                try container.viewContext.setQueryGenerationFrom(.current)
            } catch let error as NSError {
                handle(error)
            }
            return container
            
        } else {
            
            let container = NSPersistentContainer(name: self.modelName)
            container.loadPersistentStores { (storeDescription, error) in
                self.handle(error)
            }
            return container
            
        }
    }()
    
    public func saveContext(completion: @escaping (Result<Bool, Error>) -> () = {_ in}) {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
            completion(.success(true))
        } catch let error as NSError {
            handle(error) {
                completion(.failure(error))
            }
            
        }
    }
    
    private func handle(_ error: Error?,completion: @escaping () -> () = {}) {
        if let error = error as NSError? {
            let message = "CoreDataStack -> \(#function): Unresolved error: \(error), \(error.userInfo)"
            if usesFatalError {
                fatalError(message)
            } else {
                print(message)
            }
            completion()
        }
    }
}

