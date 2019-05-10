//
//  ShuxueDetailTableViewController.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 11/4/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit

class ShuxueDetailTableViewController: UITableViewController {
    var shuxue: Shuxue!{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = shuxue.name
        tableView.tableFooterView = UITableViewHeaderFooterView()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3 + (shuxue.effect?.isEmpty ?? true ? 0 : 1) + (shuxue.appliance == nil ? 0 : 1)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        switch indexPath.row {
        case 0:
            let acell = tableView.dequeueReusableCell(withIdentifier: "ShuxueTitleTableViewCell", for: indexPath) as! ShuxueTitleTableViewCell
            acell.infoLabel.text = shuxue.name
            cell = acell
        case 1:
            let acell = tableView.dequeueReusableCell(withIdentifier: "ShuxueLocatingTableViewCell", for: indexPath) as! ShuxueLocatingTableViewCell
            acell.infoLabel.text = "定位：\(shuxue.locating ?? "")"
            cell = acell
        case 2:
            let acell = tableView.dequeueReusableCell(withIdentifier: "ShuxueCureTableViewCell", for: indexPath) as! ShuxueCureTableViewCell
            acell.infoLabel.text = "\(shuxue.titleForMainCure())： \(shuxue.mainCures ?? "")"
            cell = acell
        case 3:
            let acell = tableView.dequeueReusableCell(withIdentifier: "ShuxueCureTableViewCell", for: indexPath) as! ShuxueCureTableViewCell
            acell.infoLabel.text = "作用： \(shuxue.effect ?? "")"
            cell = acell
        case 4:
            let acell = tableView.dequeueReusableCell(withIdentifier: "ShuxueApplianceTableViewCell", for: indexPath) as! ShuxueApplianceTableViewCell
            
            let appliance = JSON(shuxue.appliance as Any).arrayValue
            
            let applianceString = appliance.reduce("", { (result, json) -> String in
                var string = result
                string.append("\(String(describing: json.dictionaryValue["name"]!.stringValue))。")
                
                if let times = json.dictionaryValue["times"] {
                    string.append("\(String(describing: times.stringValue))次。\n")
                }
                
                if let times = json.dictionaryValue["duration"] {
                    string.append("\(String(describing: times.stringValue))分钟。\n")
                }
                
                return string
            })
            
            acell.infoLabel.text = "操作：\( applianceString)"
            cell = acell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
