//
//  ACRAProducts.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Product: NSObject {
    var asin: String! = nil
    var title: String! = nil
    var image_url: String! = nil
    var price_string: String! = nil
    var price_int: Int! = nil
    var rating: Double! = nil
    var displayProductQualityNumber: Int! = nil
    var displayNonProductQualityNumber: Int! = nil
    
    override init() {
        super.init()
    }
    
    override var debugDescription: String{
        let product =
            "asin: \(asin!)" +
            "\n title:\(title!)" +
            "\n image_url:\(image_url!)" +
            "\n price_string:\(price_string!)" +
            "\n price_int:\(price_int!)" +
            "\n price_int:\(displayProductQualityNumber!)" +
            "\n price_int:\(displayProductQualityNumber!)" +
            "\n rating:\(rating!)"
        
        return product
    }
    
}
