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
   
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
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
    
    var reviewCategoryName = String()
    var selectedProductTitle = String()
    
    @IBAction func buttonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Thanks For The Help!",
                                                message: "Your feedback helps improve ACRA. Are you sure this review is not related to " + self.reviewCategoryName.lowercased() + "?",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Nevermind", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes, I'm Sure", style: UIAlertActionStyle.default,handler: { action in self.sendMissclassified()}))
        
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
        self.navigationItem.backBarButtonItem?.title = "Back"
        // Set the prompt(text above title) in navigation bar
        self.navigationItem.prompt = selectedProductTitle.substring(to: selectedProductTitle.index(selectedProductTitle.startIndex, offsetBy: CoreDataHelper.setOffSet(titleCount: selectedProductTitle.characters.count)))
        
        scrollView.delegate = self;
        
        //Set the text according to the category
        setupToolbar()
        
        //Add all the data to the view
        populateViewWithData()
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: reviewText.frame.size.height + titleText.frame.size.height + 100)
        scrollView.addSubview(contentView);
        
    }
    
    //Function to set the text of the button in toolbar according to the selected category
    private func setupToolbar() {
        misclassifiedButton.title = "This Is Not Related To " + self.reviewCategoryName
        
    }
    
    private func populateViewWithData() {
        
        print(review.uid)
        titleText.text = review.summary
        reviewer.text = "By " + review.reviewerName
        reviewDate.text = " on " + review.reviewerTime
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
    
    func sendMissclassified() {
        let alertAfterCompletion = UIAlertController(title: "Thank you for the feedback!",
                                                     message: "Your feedback is on its way. Thank you for helping us make ACRA even better.",
                                                     preferredStyle: UIAlertControllerStyle.alert)
        alertAfterCompletion.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertAfterCompletion, animated: true, completion: nil)

        APIModel.sharedInstance.storeMisclassifiedGet(uid: review.uid) { (success:Bool) in
            if success {
                print("Successfully sent missclassified review")
            } else {
                print("missclassified review broke")
            }
        }
    }
    
   
//    @IBAction func logout(_ sender: Any) {
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//    }
}
