//
//  ShuxueDataSource.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 11/10/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import Foundation
import CoreData
class ShuxueDataSource {
    var earlyChildhood = false
    
    init(earlyChildhood:Bool) {
        self.earlyChildhood = earlyChildhood
    }

    func fetchedResultsController(moc: NSManagedObjectContext, format: String? = nil , predicatArgumentArray: [Any]? = nil) -> NSFetchedResultsController<Shuxue>? {
        
        let fetchRequest: NSFetchRequest<Shuxue> = Shuxue.fetchRequest()
        
        fetchRequest.sortDescriptors = []
        
        var predicateString: String?
        
        if earlyChildhood {
            predicateString = (format != nil) ? format! + "earlyChildhood == YES" : "earlyChildhood == YES"
        }
        
        var predicate: NSPredicate?
        if let formatString = predicateString {
            predicate = NSPredicate(format: formatString, argumentArray: predicatArgumentArray)
        }
        
        fetchRequest.predicate = predicate
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
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
