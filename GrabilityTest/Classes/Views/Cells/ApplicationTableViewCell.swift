//
//  ApplicationTableViewCell.swift
//  GrabilityTest
//
//  Created by Ricardo on 4/5/16.
//  Copyright © 2016 ricardo. All rights reserved.
//

import UIKit

class ApplicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var applicationImage: UIImageView!
    @IBOutlet weak var applicationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
