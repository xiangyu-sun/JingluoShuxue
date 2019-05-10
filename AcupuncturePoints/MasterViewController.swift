//
//  MasterViewController.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/20/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
    var collapseDetailViewController = true
    let menu = ["十二经络", "十二经络表里对", "十四经脉", "少儿常用推拿穴", "腧穴快查"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        navigationItem.title = "目录"
        super.viewWillAppear(animated)
    }



    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collapseDetailViewController = false
        
        selectViewControllerAtIndex(index: indexPath.row)
    }
    
    func selectViewControllerAtIndex(index: Int) {
        var present:UIViewController!
        switch index {
        case 0...2:
            if let nvc = storyboard?.instantiateViewController(withIdentifier: "JingluoNavigationVC") as? UINavigationController, let controller = nvc.topViewController as? DisplayTableViewController
            {
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                switch index{
                case 0:
                    controller.dataSource = JingluoFlowDataSource()
                case 2:
                    controller.dataSource  = JingluoYingYangDataSource()
                case 1:
                    controller.dataSource  = JingluoYingYangDataSource()
                default:
                    break
                }
                present = nvc
            }
        case 3:
            if let nvc = storyboard?.instantiateViewController(withIdentifier: "SearchNVC") as? UINavigationController, let controller = nvc.topViewController as? ShuxueSearchTableViewController
            {
                controller.navigationItem.title = "腧穴"
                
                controller.searchDataSource = ShuxueDataSource(earlyChildhood: true)
                present = nvc
            }
        case 4:
            if let nvc = storyboard?.instantiateViewController(withIdentifier: "SearchNVC") as? UINavigationController, let controller = nvc.topViewController as? ShuxueSearchTableViewController
            {
                controller.navigationItem.title = "腧穴"
                
                controller.searchDataSource = ShuxueDataSource(earlyChildhood: false)
                present = nvc
            }
        default:
            break
        }

        
        present.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        present.navigationItem.leftItemsSupplementBackButton = true
        
        splitViewController?.showDetailViewController(present, sender: self)
    }
}

extension MasterViewController: UISplitViewControllerDelegate{
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }
}

