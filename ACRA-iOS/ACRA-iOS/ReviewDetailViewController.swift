//
//  ReviewDetailViewController.swift
//  ACRA-iOS
//
//  Created by Ankit Luthra on 3/1/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewDetailViewController: UIViewController, UIScrollViewDelegate{
   
    @IBOutlet weak var Star1: UIImageView!
    @IBOutlet weak var Star2: UIImageView!
    @IBOutlet weak var Star3: UIImageView!
    @IBOutlet weak var Star4: UIImageView!
    @IBOutlet weak var Star5: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var reviewer: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var misclassifiedToolbar: UIToolbar!
    @IBOutlet weak var misclassifiedButton: UIBarButtonItem!
    
    @IBAction func buttonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Thanks For The Help!",                                                          message: "Your feedback helps improve ACRA. Are you sure this review is not related to product quality?",            preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Nevermind", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes, I'm Sure", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    
    var review = Review()

    @IBOutlet weak var scrollView: UIScrollView!
    
    var productRating = Double()
    
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
        scrollView.delegate = self;
//        titleText.text = titleList;
//        reviewer.text = "By " + reviewerList;
//        reviewDate.text = "on " + date;
//        productRating = 4.5;
//        reviewText.text = review;
        
        setupToolbar()
        
        populateViewWithData()
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: reviewText.frame.size.height + 100)
        scrollView.addSubview(contentView);
        
    }
    
    private func setupToolbar() {
        misclassifiedButton.title = "This Is Not Related To Product Quality"
        
    }
    
    private func populateViewWithData() {
        titleText.text = review.summary
        reviewer.text = "By " + review.reviewerName
        reviewDate.text = "on " + review.reviewerTime
        reviewText.text = review.reviewText
        productRating = Double(review.overall)
        
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
