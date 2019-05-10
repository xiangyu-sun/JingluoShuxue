//
//  DisplayTableViewController.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/20/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit
import CoreData



class DisplayTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{

    var jingluoSelected: Jingluo?
    
    var dataSource: JingluoDataSource!{
        didSet{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            fetchedResultsController = dataSource.fetchedResultsController(moc: appDelegate.persistentContainer.viewContext, delegate: self)
        }
    }
    
    var fetchedResultsController: NSFetchedResultsController<Jingluo>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UITableViewHeaderFooterView()
    }


    // MARK: - Table view data source

  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let jingluo = fetchedResultsController.object(at: indexPath)
        cell = tableView.dequeueReusableCell(withIdentifier: dataSource.cellIdentifier, for: indexPath)
        
        if dataSource is  JingluoYingYangDataSource{
            configureBiaoliCell(cell as! BiaoliTableViewCell, withJingLuo: jingluo)
        }else {
            configureCell(cell, withJingLuo: jingluo)
        }
        return cell
    }
    func configureBiaoliCell(_ cell: BiaoliTableViewCell, withJingLuo jingluo: Jingluo) {
        cell.biaoLabel.text = jingluo.name
        cell.liLabel.text = jingluo.li?.name
    }
    func configureCell(_ cell: UITableViewCell, withJingLuo jingluo: Jingluo) {
        cell.textLabel?.text = jingluo.name
    }
    
    // MARK: - Fetched results controller

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let segueIdentifier = dataSource.cellTapSegue {
            jingluoSelected = fetchedResultsController.object(at: indexPath)
            performSegue(withIdentifier: segueIdentifier, sender: self)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShuxuesSegue",let destination = segue.destination as? ShuxueTableViewController {
            destination.jingluo = jingluoSelected
        }
    }
    

}
