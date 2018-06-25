//
//  AppDelegate.swift
//  Listr
//
//  Created by Hesham Saleh on 1/29/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import UIKit
import CoreData
import Simperium

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var simperium: Simperium?
    var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    var managedObjectContext: NSManagedObjectContext?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Configure Simperium
        managedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext?.undoManager = nil
        
        simperium = Simperium.init(model: managedObjectModel, context: managedObjectContext, coordinator: getPersistentStoreCoordinator())
        
        // Set the login view's icon
        let spConfig = SPAuthenticationConfiguration.sharedInstance()
        spConfig?.logoImageName = "AppIcon"
        
        // Authenticate will show the login view if no user is signed in
        simperium?.authenticate(withAppID: "your-app-id", apiKey: "12345", rootViewController: self.window?.rootViewController)
        
        return true
    }

    // MARK: - Core Data stack
    func getPersistentStoreCoordinator() -> NSPersistentStoreCoordinator {
        if (persistentStoreCoordinator != nil) {
            return persistentStoreCoordinator!
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask
.userDomainMask, true)
        let documentsDirectory = paths[0]
        let path = documentsDirectory.appending("/Listr.sqlite")
        let storeUrl = NSURL.fileURL(withPath: path, isDirectory:false)
        persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: self.managedObjectModel)
        do {
            try persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        } catch {
            NSLog("Could not create custom store")
        }
        
        return persistentStoreCoordinator!
    }
    
    var managedObjectModel: NSManagedObjectModel = {
        let path = Bundle.main.path(forResource: "Listr", ofType: "momd")
        let model = NSManagedObjectModel.init(contentsOf: NSURL.fileURL(withPath: path!))
        
        return model!
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if (context?.hasChanges)! {
            do {
                try context?.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//Shortcuts
let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.managedObjectContext










