//
//  ACRAReviews.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Reviews: NSObject {
    
    //Product quality reviews
    var reReviews: [Review] = []
    var posReviews: [Review] = []
    var negReviews: [Review] = []
    
    //Irrelvant reviews
    var irReview: [Review] = []
    var numReviews: Int! = nil 
    
    static let sharedReviews = Reviews()
    
    
    override init () {
        super.init()
    }
    
    
    
    func addReview(review: Review) {
        
        // add to different list based on related or not
        if review.relevant! {
//            if !reReviews.contains(review) {
//                reReviews.append(review)
//            }
            
            if review.overall >= 3 {
                if posReviews.contains(review) {
                    posReviews.append(review)
                }
            }
            if review.overall <= 2 {
                if !negReviews.contains(review) {
                    negReviews.append(review)
                }
            }
        }
        else {
            if !irReview.contains(review) {
                irReview.append(review)
            }
        }
    }
    
    func clearReviews() {
//        reviews.removeAll()
//        reReviews.removeAll()
        posReviews.removeAll()
        negReviews.removeAll()
        irReview.removeAll()
    }
}
