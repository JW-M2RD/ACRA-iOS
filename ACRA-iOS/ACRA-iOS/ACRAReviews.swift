//
//  ACRAReviews.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Reviews: NSObject {
    
    var reReviews: [Review] = []
    var irReview: [Review] = []
    var numReviews: Int! = nil 
    
    static let sharedReviews = Reviews()
    
    
    override init () {
        super.init()
    }
    
    
    
    func addReview(review: Review) {
//        if !reviews.contains(review) {
//            reviews.append(review)
//        }
        if review.relevant! {
            if !reReviews.contains(review) {
                reReviews.append(review)
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
        reReviews.removeAll()
        irReview.removeAll()
    }
}
