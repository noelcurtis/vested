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
        println(urls[urls.count-1])
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
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "com.noelcurtis", code: 9999, userInfo: dict)
            //TODO (noelcurtis): should not abort here but allow to fail gracefully
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
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
        if coordinator!.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil, error: &error) == nil {
            coordinator = nil
            NSLog("Shizt! \(error), \(error!.userInfo)")
            abort()
        }
        
        var managedObjextContext = NSManagedObjectContext()
        managedObjextContext.persistentStoreCoordinator = coordinator
        return managedObjextContext
    }()

    class var sharedInstance: PersistenceService {
        return _PersistenceServiceSharedInstance
    }
    
    
    //    func saveContext () {
    //        if let moc = self.managedObjectContext {
    //            var error: NSError? = nil
    //            if moc.hasChanges && !moc.save(&error) {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                NSLog("Unresolved error \(error), \(error!.userInfo)")
    //                abort()
    //            }
    //        }
    //    }
    
}
