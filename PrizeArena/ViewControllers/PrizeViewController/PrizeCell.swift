//
//  PrizeCell.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 09/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import UIKit
//import SnapKit

class PrizeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var freeSlotsLabel: UILabel!
    @IBOutlet weak var totalSlotsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // image placeholder: width: 188px, height: 199px, rgb(245, 245, 245)
        titleLabel.font = UIFont(name: "Aleo-Bold", size: FontSizes.large)
        titleLabel.textColor = Colors.darkFont
        freeSlotsLabel.font = UIFont(name: "Aleo-Regular", size: FontSizes.medium)
        freeSlotsLabel.textColor = Colors.primary
        totalSlotsLabel.font = UIFont(name: "Aleo-Regular", size: FontSizes.small)
        totalSlotsLabel.textColor = Colors.lightFont
        makeConstraints()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func makeConstraints() {
        //        let superview = self.contentView
        //        titleLabel.snp_makeConstraints { make in
        //        make.top.equalTo(superview).offset(34)
        //        make.left.equalTo(superview).offset(34)
        //        }
        //
        //        freeSlotsLabel.snp_makeConstraints { make in
        //            make.bottom.equalTo(superview).offset(34)
        //            make.left.equalTo(superview).offset(34)
        //        }
        //
        //        totalSlotsLabel.snp_makeConstraints { make in
        //            make.bottom.equalTo(superview).offset(34)
        //            make.right.equalTo(superview).offset(34)
        //        }
    }
    
}
