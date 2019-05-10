//
//  ShuxueTableViewCell.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/24/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit

class ShuxueTableViewCell: UITableViewCell {

    @IBOutlet weak var locatingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainCureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
