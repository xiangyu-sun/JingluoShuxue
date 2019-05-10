//
//  YuXueSearchTableViewController.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/24/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit
import CoreData
class ShuxueSearchTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let searchController = UISearchController(searchResultsController: nil)

    var fetchedResultsController: NSFetchedResultsController<Shuxue>!{
        didSet{
            fetchedResultsController.delegate = self
        }
    }
    var searchDataSource: ShuxueDataSource!{
        didSet{
            let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            fetchedResultsController = searchDataSource.fetchedResultsController(moc: ctx)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "腧穴名字"
        searchController.delegate = self
        definesPresentationContext = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.searchController = searchController
        
    }

   

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShuxueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShuxueTableViewCell", for: indexPath) as! ShuxueTableViewCell
        let shuxue = fetchedResultsController.object(at: indexPath)
        
        cell.nameLabel.text = "\(shuxue.name ?? "")"
        cell.mainCureLabel.text = "主治：\(shuxue.mainCures ?? "")"
        cell.locatingLabel.text = "定位：\(shuxue.locating ?? "")"

        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShuxueDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow{
             let shuxue = fetchedResultsController.object(at: indexPath)
            destination.shuxue = shuxue
        }
    }
    
    // MARK: - Fetched results controller
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
extension ShuxueSearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
   
        
        fetchedResultsController = searchDataSource.fetchedResultsController(moc: appDelegate.persistentContainer.viewContext,format: "(name CONTAINS %@) OR (mainCures CONTAINS %@)",predicatArgumentArray: [searchText, searchText])
        
        tableView.reloadData()

    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        fetchedResultsController = searchDataSource.fetchedResultsController(moc: appDelegate.persistentContainer.viewContext)
        
        tableView.reloadData()
    }
}
