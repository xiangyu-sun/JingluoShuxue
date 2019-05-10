//
//  ShuxueTableViewController.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/20/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit

class ShuxueTableViewController: UITableViewController {
    
    var jingluo: Jingluo!{
        didSet{
            shuxues = jingluo.shuxues?.allObjects as? [Shuxue]
            tableView.reloadData()
        }
    }
    var shuxues:[Shuxue]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = jingluo.name
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shuxues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShuxueCell", for: indexPath)
        let shuxue = shuxues[indexPath.row]
        configCell(cell, withShuxue: shuxue)
        
        
        return cell
    }
    
    func configCell(_ cell:UITableViewCell, withShuxue shuxue: Shuxue) {
        cell.textLabel?.text = shuxue.name
        cell.detailTextLabel?.text = shuxue.mainCures?.description
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShuxueDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow{
            let shuxue = shuxues[indexPath.row]
            destination.shuxue = shuxue
        }
    }
    
}
