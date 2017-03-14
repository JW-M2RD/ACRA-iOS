//
//  ReviewDetailViewController.swift
//  ACRA-iOS
//
//  Created by Ankit Luthra on 3/1/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewDetailViewController: UIViewController {
   
    @IBOutlet weak var Star1: UIImageView!
    @IBOutlet weak var Star2: UIImageView!
    @IBOutlet weak var Star3: UIImageView!
    @IBOutlet weak var Star4: UIImageView!
    @IBOutlet weak var Star5: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var reviewer: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!

    var productRating = Double()

    
    var titleList = "Very Happy"
    var reviewerList = "quirt27"
    var reviewText = ["Love the new TV. Picture is awesome and set up was quick and easy. Also love Amazon's enhanced delievery......was very nice to have such a large... While I watch a lot of TV, I'd never claim to be an expert on the differences between models. So when the time came to buy a new one, I went... Considering the price I paid which was a bit less than $1100.00, I will rate this 5 stars. It has a good crisp picture. With a larger screen I... Absolutely stunning 4K TV for the money. Put this TV next to an old HD Sony I was replacing. With normal HD streaming the upscaling gave a remarkably better picture. Of course its"]
    var date = "January 13, 2017"
    
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 1 > starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = titleList;
        reviewer.text = "By " + reviewerList;
        reviewDate.text = "on " + date;
        productRating = 4.5;
        Star1.image = getStarImage(starNumber: 1, forRating: productRating)
        Star2.image = getStarImage(starNumber: 2, forRating: productRating)
        Star3.image = getStarImage(starNumber: 3, forRating: productRating)
        Star4.image = getStarImage(starNumber: 4, forRating: productRating)
        Star5.image = getStarImage(starNumber: 5, forRating: productRating)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resoureces that can be recreated
    }
    
}
