//
//  PrizeCell.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 09/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import UIKit

class PrizeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var freeSlotsLabel: UILabel!
    @IBOutlet weak var totalSlotsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
