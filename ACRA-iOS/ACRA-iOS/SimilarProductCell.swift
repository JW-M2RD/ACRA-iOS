//
//  SimilarProductCell.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/22/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class SimilarProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var productQualityNum: UILabel!
    @IBOutlet weak var NonProductQualityNum: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!

    
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 1 > starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }

    
    func setupSimilarCell (prImage: UIImage, name: String,  productQuality: Int, nonProductQuality: Int, productRating: Double, price: String) {
        
        productImage.image = prImage
        productName.text = name
        
        star1.image = getStarImage(starNumber: 1, forRating: productRating)
        star2.image = getStarImage(starNumber: 2, forRating: productRating)
        star3.image = getStarImage(starNumber: 3, forRating: productRating)
        star4.image = getStarImage(starNumber: 4, forRating: productRating)
        star5.image = getStarImage(starNumber: 5, forRating: productRating)
        
        productQualityNum.text = String(productQuality)
        NonProductQualityNum.text = String(nonProductQuality)
        productPrice.text = price
    }

}
