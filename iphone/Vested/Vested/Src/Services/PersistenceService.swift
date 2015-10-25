//
//  CoreDataProvider.swift
//  Vested
//
//  Created by ncurtis on 1/15/15.
//  Copyright (c) 2015 noelcurtis. All rights reserved.
//

import CoreData

private let _PersistenceServiceSharedInstance = PersistenceService()

class PersistenceService {
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("VestedDataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Vested.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true ]
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "com.noelcurtis", code: 9999, userInfo: dict)
            //TODO (noelcurtis): should not abort here but allow to fail gracefully
            NSLog("Shizt! cant create the persistent store \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    lazy var inMemoryManagedObjectContext : NSManagedObjectContext? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        var error: NSError? = nil
        do {
            try coordinator!.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            NSLog("Shizt adding persistent store \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        var managedObjextContext = NSManagedObjectContext()
        managedObjextContext.persistentStoreCoordinator = coordinator
        
        return managedObjextContext
    }()

    class var sharedInstance: PersistenceService {
        return _PersistenceServiceSharedInstance
    }
    
}
