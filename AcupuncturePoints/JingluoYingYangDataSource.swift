//
//  JingluoYingYangDataSource.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/24/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//
import Foundation
import CoreData

protocol JingluoDataSource {
    var cellIdentifier: String { get}
    var cellTapSegue: String? { get }
    func fetchedResultsController(moc: NSManagedObjectContext, delegate:NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Jingluo>?
}

class JingluoYingYangDataSource: JingluoDataSource {
    let cellIdentifier = "BiaoliTableViewCell"
    let cellTapSegue: String? = "ShuxuesSegue"
    
    func fetchedResultsController(moc: NSManagedObjectContext, delegate:NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Jingluo>? {
        
        let fetchRequest: NSFetchRequest<Jingluo> = Jingluo.fetchRequest()
        let cacheName = "JingluoYingYangSearch"
        fetchRequest.predicate = NSPredicate(format: "yang == %@ ", argumentArray:[true])
        fetchRequest.sortDescriptors = []
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: cacheName)
        aFetchedResultsController.delegate = delegate
        do {
            try aFetchedResultsController.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            return nil
        }
        
        return aFetchedResultsController
    }
}
