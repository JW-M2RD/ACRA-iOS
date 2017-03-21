//
//  HeaderCellProductSort.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/21/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class HeaderCellProductSort: UITableViewCell {  
    //MARK: Properties
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
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
