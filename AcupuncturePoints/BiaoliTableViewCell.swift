//
//  BiaoliTableViewCell.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/21/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit

class BiaoliTableViewCell: UITableViewCell {

    @IBOutlet weak var biaoLabel: UILabel!
    @IBOutlet weak var liLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
