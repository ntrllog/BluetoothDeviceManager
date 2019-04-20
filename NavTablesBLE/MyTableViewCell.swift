//
//  MyTableViewCell.swift
//  NavTablesBLE
//
//  Created by Alan Lam on 4/20/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var myRSSILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
