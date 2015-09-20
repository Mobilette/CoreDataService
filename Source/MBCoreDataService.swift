//
//  MBCoreDataService.swift
//  CoreDataService
//
//  Created by Romain ASNAR on 9/20/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import UIKit
import CoreData

public class MBCoreDataService
{
    // MARK: - Property
    
    static var managedObjectContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return appDelegate.managedObjectContext
        }
        return nil
    }
    
    // MARK: - Core data service
    
    public class func managedObjectWithEntityName(
        entityName: String
        ) -> NSManagedObject?
    {
        if let managedObjectContext = MBCoreDataService.managedObjectContext {
            return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedObjectContext) as? NSManagedObject
        }
        return nil
    }
    
    public class func saveNewChanges() -> NSError?
    {
        if let managedObjectContext = MBCoreDataService.managedObjectContext {
            var error: NSError? = nil
            if managedObjectContext.hasChanges && managedObjectContext.save(&error) {
                return nil
            }
            return error
        }
        return CoreDataServiceError.ManagedObjectContextIsNil.error
    }
    
    public class func fetchManagedObjects(
        #entityName: String,
        predicate: NSPredicate? = nil,
        sort: [NSSortDescriptor]? = nil
        ) -> [NSManagedObject]?
    {
        var fetchRequest: NSFetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sort
        if let managedObjectContext = MBCoreDataService.managedObjectContext {
            var error: NSError? = nil
            if let entities = managedObjectContext.executeFetchRequest(fetchRequest, error:&error) as? [NSManagedObject] {
                return entities
            }
            return nil
        }
        return nil
    }
    
    public class func deleteAllEntities(entityName: String) -> NSError?
    {
        if let managedObjectContext = MBCoreDataService.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: entityName)
            fetchRequest.includesPendingChanges = false
            var fetchRequestError: NSError? = nil
            if let entities = managedObjectContext.executeFetchRequest(fetchRequest, error: &fetchRequestError) as? [NSManagedObject] {
                for entity in entities {
                    managedObjectContext.deleteObject(entity)
                }
                var saveRequestError: NSError? = nil
                managedObjectContext.save(&saveRequestError)
                return saveRequestError
            }
            return fetchRequestError
        }
        return CoreDataServiceError.ManagedObjectContextIsNil.error
    }
    
    // MARK: - Error
    
    enum CoreDataServiceError
    {
        case NoResults
        case ManagedObjectContextIsNil
        
        var code: Int {
            switch self {
            case .NoResults:
                return 404
            case .ManagedObjectContextIsNil:
                return 500
            }
        }
        
        var domain: String {
            return "CoreDataServiceDomain"
        }
        
        var description: String {
            switch self {
            case .NoResults:
                return "No results for fetch request."
            case .ManagedObjectContextIsNil:
                return "Managed object context is nil."
            }
        }
        
        var reason: String {
            switch self {
            case .NoResults:
                return "The result of fetch request is empty."
            case .ManagedObjectContextIsNil:
                return "Managed object context is nil."
            }
        }
        
        var error: NSError {
            let userInfo = [
                NSLocalizedDescriptionKey: self.description,
                NSLocalizedFailureReasonErrorKey: self.reason
            ]
            return NSError(domain: self.domain, code: self.code, userInfo: userInfo)
        }
    }
}