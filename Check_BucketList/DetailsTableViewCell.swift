//
//  DetailsTableViewCell.swift
//  Check_BucketList
//
//  Created by Matan on 12/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
        
    @IBOutlet weak var note1: UILabel!
   
    @IBOutlet weak var note2: UILabel!
    
    @IBOutlet weak var commitment: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
