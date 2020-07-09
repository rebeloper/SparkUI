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
    
    public init(modelName: String, usesCloudKit: Bool = false) {
        self.modelName = modelName
        self.usesCloudKit = usesCloudKit
    }
    
    public lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        
        if usesCloudKit {
            
            let container = NSPersistentCloudKitContainer(name: self.modelName)
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
            
            do {
                try container.viewContext.setQueryGenerationFrom(.current)
            } catch {
                fatalError("###\(#function): Failed to pin viewContext to the current generation:\(error)")
            }
            return container
            
        } else {
            
            let container = NSPersistentContainer(name: self.modelName)
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
            
        }
    }()
    
    public func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

