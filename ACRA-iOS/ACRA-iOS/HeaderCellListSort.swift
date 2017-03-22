//
//  HeaderCellListSort.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/21/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class HeaderCellListSort: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell (image: UIImage, labelText: String) {
        headerImage.image = image
        headerLabel.text = labelText
    }
    
}
