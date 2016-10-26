//
//  CustomTableViewCell.swift
//  TestDemo
//
//  Created by Faisal Maqsood on 25/10/2016.
//  Copyright © 2016 NenuTech. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var travelImage: UIImageView!
    
    
    @IBOutlet weak var departureTimeLabel: UILabel!
    
    
    @IBOutlet weak var travelPrice: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
