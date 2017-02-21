//
//  ReviewListCell.swift
//  ACRA-iOS
//
//  Created by Mr.RD on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewListCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var reviewer: UILabel!
    @IBOutlet weak var ReviewText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
